Return-Path: virtio-dev-return-4345-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B7B15818F87
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Jun 2018 18:54:55 -0700 (PDT)
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <20180611202207-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
Date: Tue, 12 Jun 2018 09:54:44 +0800
MIME-Version: 1.0
In-Reply-To: <20180611202207-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY feature
 bit to virtio_net
To: "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年06月12日 01:26, Michael S. Tsirkin wrote:
> On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote:
>> This feature bit can be used by hypervisor to indicate virtio_net device to
>> act as a standby for another device with the same MAC address.
>>
>> I tested this with a small change to the patch to mark the STANDBY feature 'true'
>> by default as i am using libvirt to start the VMs.
>> Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
>> XML file?
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> So I do not think we can commit to this interface: we
> really need to control visibility of the primary device.

The problem is legacy guest won't use primary device at all if we do this.

How about control the visibility of standby device?

Thanks

> However just for testing purposes, we could add a non-stable
> interface "x-standby" with the understanding that as any
> x- prefix it's unstable and will be changed down the road,
> likely in the next release.
>
>
>> ---
>>   hw/net/virtio-net.c                         | 2 ++
>>   include/standard-headers/linux/virtio_net.h | 3 +++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 90502fca7c..38b3140670 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>>                        true),
>>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
>> +                      false),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
>> index e9f255ea3f..01ec09684c 100644
>> --- a/include/standard-headers/linux/virtio_net.h
>> +++ b/include/standard-headers/linux/virtio_net.h
>> @@ -57,6 +57,9 @@
>>   					 * Steering */
>>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>>   
>> +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
>> +                                         * with the same MAC.
>> +                                         */
>>   #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>>   
>>   #ifndef VIRTIO_NET_NO_LEGACY
>> -- 
>> 2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

