/*
 * Copyright (c) 2011, University of Szeged
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Andras Biro
 */

/*
 * Pin change interrupt HPL for atmega128rfa1 PCINT0:7 (PORTB0:7)
 */
module HplAtmegaPinChange0C
{
  provides interface HplAtmegaPinChange;
}
implementation
{
// ----- pin change interrupt flag register (PCIFR)

  /* Tests if an interrupt is pending */
  async command bool HplAtmegaPinChange.test(){
    return (PCIFR&(1<<PCIF0))!=0;
  }

  /* Resets a pending interrupt */
  async command void HplAtmegaPinChange.reset(){
    PCIFR|=1<<PCIF0;
  }

// ----- pin change control register (PCICR)

  /* Enables the interrupt */
  async command void HplAtmegaPinChange.enable(){
    PCICR|=1<<PCIE0;
  }

  /* Disables the interrupt */
  async command void HplAtmegaPinChange.disable(){
    PCICR&=~(1<<PCIE0);
  }

  /* Checks if the interrupt is enabled */
  async command bool HplAtmegaPinChange.isEnabled(){
    return (PCICR&(1<<PCIE0))!=0;
  }

// ----- pin change mask register (PCMSK)

  /* Reads the mask register */
  async command uint8_t HplAtmegaPinChange.getMask(){
    return PCMSK0;
  }

  /* Sets the mask register */
  async command void HplAtmegaPinChange.setMask(uint8_t value){
    PCMSK0=value;
  }

// ----- pin register (PIN)

  /* Reads the current pin values */
  async command uint8_t HplAtmegaPinChange.getPins(){
    return PINB;
  }
  
  /* Signalled when any of the enabled pins changed */  
  AVR_ATOMIC_HANDLER( PCINT0_vect ) {
    signal HplAtmegaPinChange.fired();
  }

  default async event void HplAtmegaPinChange.fired(){}
}
