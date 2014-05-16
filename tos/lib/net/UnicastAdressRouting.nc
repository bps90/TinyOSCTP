/* $Id: UnicastNameFreeRouting.nc,v 1.4 2006-12-12 18:23:29 vlahan Exp $ */
/*
 * "Copyright (c) 2013 The Regents of the University  of Minas Gerais.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright.
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the University of California nor
 *   the names of its contributors may be used to endorse or promote
 *   products derived from this software without specific prior written
 *   permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * REGENTS OF THE UNVERSITY OF CALIFORNIA OR ITS CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

/**
 *  Provides a single next hop on a protocol given an destination.
 *
 *  @author BRUNO Pereira
 *  @date   $Date: 2006-12-12 18:23:29 $
 */
interface UnicastAdressRouting {

  /**
   * Get the address of the next hop set to the destination param.
   * If there is not next hop, the address is the local address.
   * @return : The next hop, or the local address if there is no route.
   */
  command am_addr_t nextHop(am_addr_t dest);
  
  /**
   * Verifica se existe rota na tabela sonsTable para destination param.
   * @return : TRUE se existe uma rota para destination param, 
   * ou FALSE caso contrário.
   */
  command bool hasRoute(am_addr_t dest);
  
  /**
   * Quando uma nova entrada na sonsTable é feita este evento é sinalizado
   * @return : endereço que foi encontrado.
   */
  event am_addr_t routeFound();
  
  /**
   * Este evento é sinalizado quando não existe rota para um dado destino.
   */
  event void noRoute(am_addr_t dest);
}

