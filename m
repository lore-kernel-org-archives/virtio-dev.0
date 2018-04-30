Return-Path: virtio-dev-return-4017-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 713C6581810B
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Apr 2018 12:14:31 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-2-git-send-email-sridhar.samudrala@intel.com>
 <20180428075027.GI5632@nanopsycho.orion>
 <9826909e-d6cd-a0a3-142f-6f7f8cf2b5ce@intel.com>
 <20180430070340.GF23854@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <392e664e-4605-1047-c24f-ca8531858a25@intel.com>
Date: Mon, 30 Apr 2018 12:14:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180430070340.GF23854@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 1/4] virtio_net: Introduce
 VIRTIO_NET_F_STANDBY feature bit
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/30/2018 12:03 AM, Jiri Pirko wrote:
> Mon, Apr 30, 2018 at 04:47:03AM CEST, sridhar.samudrala@intel.com wrote:
>> On 4/28/2018 12:50 AM, Jiri Pirko wrote:
>>> Fri, Apr 27, 2018 at 07:06:57PM CEST,sridhar.samudrala@intel.com  wrote:
>>>> This feature bit can be used by hypervisor to indicate virtio_net device to
>>>> act as a standby for another device with the same MAC address.
>>>>
>>>> VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.
>>>>
>>>> Signed-off-by: Sridhar Samudrala<sridhar.samudrala@intel.com>
>>>> ---
>>>> drivers/net/virtio_net.c        | 2 +-
>>>> include/uapi/linux/virtio_net.h | 3 +++
>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 3b5991734118..51a085b1a242 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
>>>> 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>>>> 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>>>> 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>>>> -	VIRTIO_NET_F_SPEED_DUPLEX
>>>> +	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
>>> This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
>>> Were I can find the qemu code?
>>>
>>> Also, I think it makes sense to push HW (qemu HW in this case) first
>>> and only then the driver.
>> I had sent qemu patch with a couple of earlier versions of this patchset.
>> Will include it when i send out v10.
> The point was, don't you want to push it to qemu first? Did you at least
> send RFC to qemu?

Yes. Here is the link to the RFC patch.
https://patchwork.ozlabs.org/patch/859521/




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

