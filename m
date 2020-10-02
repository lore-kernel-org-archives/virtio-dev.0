Return-Path: virtio-dev-return-7815-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FCA99860BB
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Oct 2020 08:18:27 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
 <20200918165558.257086-1-peter.hilber@opensynergy.com>
 <20200923205433.GB1285024@bogus>
Message-ID: <9ba94147-8e83-1122-a900-f4b50d783909@opensynergy.com>
Date: Fri, 2 Oct 2020 10:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20200923205433.GB1285024@bogus>
Subject: [virtio-dev] Re: [RFC PATCH 6/7] dt-bindings: arm: Add virtio transport for SCMI
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Peter Hilber <peter.hilber@opensynergy.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, souvik.chakravarty@arm.com, alex.bennee@linaro.org, jean-philippe@linaro.org, igor.skalkin@opensynergy.com, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 23.09.20 22:54, Rob Herring wrote:
> On Fri, Sep 18, 2020 at 06:55:58PM +0200, Peter Hilber wrote:
>> From: Igor Skalkin <igor.skalkin@opensynergy.com>
>>
>> Document the properties for arm,scmi-virtio compatible nodes. The
>> backing virtio SCMI device is described in patch [1].
>>
>> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
>>
>> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
>> ---
>>  .../devicetree/bindings/arm/arm,scmi.txt      | 38 ++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> index 55deb68230eb..844ff3c40a49 100644
>> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> @@ -13,6 +13,9 @@ the device tree.
>>  Required properties:
>>  
>>  The scmi node with the following properties shall be under the /firmware/ node.
>> +Some properties are specific to a transport type.
>> +
>> +shmem-based transports (mailbox, smc/hvc):
>>  
>>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
>>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
>> @@ -21,6 +24,17 @@ The scmi node with the following properties shall be under the /firmware/ node.
>>  	  supported.
>>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>>  	  generic mailbox client binding.
>> +
>> +Virtio transport:
>> +
>> +- compatible : shall be "arm,scmi-virtio".
>> +- virtio_transport : phandle of the virtio device. This device must support one
>> +                     virtqueue for transmitting commands ("tx", cmdq), and,
>> +		     optionally, one more virtqueue for receiving notifications
>> +		     and delayed responses ("rx", eventq).
> 
> Isn't what the virtio device provides discoverable? We don't have virtio 
> protocols in DT for anything else. Why is SCMI special?
> 
> Rob
> 

Does your comment refer to the presence of the `virtio_transport'
phandle, or to the entire "arm,scmi-virtio" node? The protocol child
nodes of "arm,scmi-virtio" can be clock providers, power domain
providers, etc.

The author and me are currently looking into how to replace
the `virtio_transport' phandle.

Best regards,

Peter

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

