/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* global getAssetRegistry */

/**
 * iot blockchain Transaction
 * @param  {org.hyperledger_composer.iot.IOTTransaction} IOTTransaction - the data asset transaction
 * @transaction
 */
async function IOTTransaction(TrackInfo) {   // eslint-disable-line no-unused-vars
    // const assetRegistry = await getAssetRegistry('org.hyperledger_composer.iot.IOTAsset');
    let factory = getFactory(); 

    let basicEvent = factory.newEvent('org.hyperledger_composer.iot', 'IOTEvent');
   	if(TrackInfo.criticality > 10) {
   		emit(basicEvent)
   	}
}
