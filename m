Return-Path: virtio-dev-return-4355-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3270D58191EC
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Jun 2018 17:08:57 -0700 (PDT)
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <20180611202207-mutt-send-email-mst@kernel.org>
 <dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
 <20180612051432-mutt-send-email-mst@kernel.org>
 <23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
 <20180612142557-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
Date: Tue, 12 Jun 2018 17:08:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180612142557-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 6/12/2018 4:34 AM, Michael S. Tsirkin wrote:
> On Mon, Jun 11, 2018 at 10:02:45PM -0700, Samudrala, Sridhar wrote:
>> On 6/11/2018 7:17 PM, Michael S. Tsirkin wrote:
>>> On Tue, Jun 12, 2018 at 09:54:44AM +0800, Jason Wang wrote:
>>>> On 2018年06月12日 01:26, Michael S. Tsirkin wrote:
>>>>> On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote:
>>>>>> This feature bit can be used by hypervisor to indicate virtio_net device to
>>>>>> act as a standby for another device with the same MAC address.
>>>>>>
>>>>>> I tested this with a small change to the patch to mark the STANDBY feature 'true'
>>>>>> by default as i am using libvirt to start the VMs.
>>>>>> Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
>>>>>> XML file?
>>>>>>
>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>> So I do not think we can commit to this interface: we
>>>>> really need to control visibility of the primary device.
>>>> The problem is legacy guest won't use primary device at all if we do this.
>>> And that's by design - I think it's the only way to ensure the
>>> legacy guest isn't confused.
>> Yes. I think so. But i am not sure if Qemu is the right place to control the visibility
>> of the primary device. The primary device may not be specified as an argument to Qemu. It
>> may be plugged in later.
>> The cloud service provider is providing a feature that enables low latency datapath and live
>> migration capability.
>> A tenant can use this feature only if he is running a VM that has virtio-net with failover support.
> Well live migration is there already. The new feature is low latency
> data path.

we get live migration with just virtio.  But I meant live migration with VF as
primary device.

>
> And it's the guest that needs failover support not the VM.

Isn't guest and VM synonymous?


>
>
>> I think Qemu should check if guest virtio-net supports this feature and provide a mechanism for
>> an upper layer indicating if the STANDBY feature is successfully negotiated or not.
>> The upper layer can then decide if it should hot plug a VF with the same MAC and manage the 2 links.
>> If VF is successfully hot plugged, virtio-net link should be disabled.
> Did you even talk to upper layer management about it?
> Just list the steps they need to do and you will see
> that's a lot of machinery to manage by the upper layer.
>
> What do we gain in flexibility? As far as I can see the
> only gain is some resources saved for legacy VMs.
>
> That's not a lot as tenant of the upper layer probably already has
> at least a hunch that it's a new guest otherwise
> why bother specifying the feature at all - you
> save even more resources without it.
>

I am not all that familiar with how Qemu manages network devices. If we can do all the
required management of the primary/standby devices within Qemu, that is definitely a better
approach without upper layer involvement.


>
>
>>>> How about control the visibility of standby device?
>>>>
>>>> Thanks
>>> standy the always there to guarantee no downtime.
>>>
>>>>> However just for testing purposes, we could add a non-stable
>>>>> interface "x-standby" with the understanding that as any
>>>>> x- prefix it's unstable and will be changed down the road,
>>>>> likely in the next release.
>>>>>
>>>>>
>>>>>> ---
>>>>>>     hw/net/virtio-net.c                         | 2 ++
>>>>>>     include/standard-headers/linux/virtio_net.h | 3 +++
>>>>>>     2 files changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>>> index 90502fca7c..38b3140670 100644
>>>>>> --- a/hw/net/virtio-net.c
>>>>>> +++ b/hw/net/virtio-net.c
>>>>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>>>>>>                          true),
>>>>>>         DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>>>>>>         DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>>>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
>>>>>> +                      false),
>>>>>>         DEFINE_PROP_END_OF_LIST(),
>>>>>>     };
>>>>>> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
>>>>>> index e9f255ea3f..01ec09684c 100644
>>>>>> --- a/include/standard-headers/linux/virtio_net.h
>>>>>> +++ b/include/standard-headers/linux/virtio_net.h
>>>>>> @@ -57,6 +57,9 @@
>>>>>>     					 * Steering */
>>>>>>     #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>>>>>> +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
>>>>>> +                                         * with the same MAC.
>>>>>> +                                         */
>>>>>>     #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>>>>>>     #ifndef VIRTIO_NET_NO_LEGACY
>>>>>> -- 
>>>>>> 2.14.3
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

