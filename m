Return-Path: virtio-dev-return-3433-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 49DE55818F0F
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Mar 2018 10:02:23 -0800 (PST)
References: <cover.1519961667.git.jbaron@akamai.com>
 <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
 <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
 <20180302221831-mutt-send-email-mst@kernel.org>
 <258F88CA-D946-4804-A65D-2EA0790A66AF@redhat.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <09cbf694-907e-dd68-60ff-eeb169925a5e@akamai.com>
Date: Tue, 6 Mar 2018 13:02:06 -0500
MIME-Version: 1.0
In-Reply-To: <258F88CA-D946-4804-A65D-2EA0790A66AF@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 4/4] virtio-net: add linkspeed and duplex
 settings to virtio-net
To: Yan Vugenfirer <yvugenfi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/04/2018 08:05 AM, Yan Vugenfirer wrote:
> 
> 
>> On 2 Mar 2018, at 22:19, Michael S. Tsirkin <mst@redhat.com
>> <mailto:mst@redhat.com>> wrote:
>>
>> On Fri, Mar 02, 2018 at 03:14:01PM +0800, Jason Wang wrote:
>>>
>>>
>>> On 2018年03月02日 11:46, Jason Baron wrote:
>>>> Although linkspeed and duplex can be set in a linux guest via
>>>> 'ethtool -s',
>>>> this requires custom ethtool commands for virtio-net by default.
>>>>
>>>> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
>>>> the hypervisor to export a linkspeed and duplex setting. The user can
>>>> subsequently overwrite it later if desired via: 'ethtool -s'.
>>>>
>>>> Linkspeed and duplex settings can be set as:
>>>> '-device virtio-net,speed=10000,duplex=full'
>>>
>>> I was thinking whether or not it's better to decide the duplex by the
>>> type
>>> of backends.
>>>
>>> E.g userspace and vhost-kernel implement a in fact half duplex. But dpdk
>>> implement a full duplex.
>>>
>>> Thanks
>>
>> OTOH it's a priority for some people to be able to support migration
>> between different backend types. Breaking that won't be nice.
> 
> I think that in this case we need a way to update the settings of link
> speed and link duplex (maybe add QMP command). Migration between
> different backend types should cause link down\link up events. And this
> is a time for a driver to re-read the settings and update the OS.
> 
> Best regards,
> Yan.
> 

So the virtio_net driver in linux will re-read these settings on link up
events. So I could add a qmp command to set these (in addition to the
command-line) interface, if desired. Is there a consensus that we need
to add a qmp command here? Or can that be treated as a future item, if
somebody wants it?

Thanks,

-Jason

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

