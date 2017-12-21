Return-Path: virtio-dev-return-2875-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EF472581916C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2017 10:44:29 -0800 (PST)
References: <bf96d8c2-4aac-cdfd-24b9-218e0f89a7ef@akamai.com>
 <20171220165749-mutt-send-email-mst@kernel.org>
 <253C90BB-3BBD-4E01-800C-C88408B27F01@redhat.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <5889defa-aef4-3bd0-bce0-e311f68388be@akamai.com>
Date: Thu, 21 Dec 2017 13:44:15 -0500
MIME-Version: 1.0
In-Reply-To: <253C90BB-3BBD-4E01-800C-C88408B27F01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Add VIRTIO_NET_F_SPEED_DUPLEX (4) feature bit
To: Yan Vugenfirer <yvugenfi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/21/2017 06:37 AM, Yan Vugenfirer wrote:
> 
>> On 20 Dec 2017, at 17:00, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Dec 14, 2017 at 03:31:54PM -0500, Jason Baron wrote:
>>> Hi,
>>>
>>> We have found it useful to have the virtio net device export a linkspeed
>>> and duplex setting, such that a guest linkspeed and duplex settings can
>>> be set automatically from the host side. We have some guest software
>>> that relies on this setting, and fails without a valid value provided.
>>
>> That software really should be fixed btw. You can't always reliably
>> figure out the speed, and it might change at any time.
>>
> Good point. Each time when there is a linked up indication from the host, we should expect that the settings can be different (for example backend changed).
> 

Indeed, I didn't implement the ability to dynamically update the
linkspeed via the host(say via a qemu monitor command), because I didn't
need it. But it could be added later if somebody wanted it...

Thanks,

-Jason

>>> Thus, I would like to propose adding a new feature bit:
>>>
>>> VIRTIO_NET_F_SPEED_DUPLEX (4) Device provides a linkspeed and duplex setting
>>
>>
>> I think a high feature bit would be better. Low bits can be
>> backported to legacy devices, so better used for things
>> like mtu, where communication just breaks otherwise,
>> and for net we are running out of these.
>>
>>
>>> I have provided sample qemu hypervisor and linux kernel guest code to
>>> implement this feature here:
>>>
>>> http://lkml.iu.edu/hypermail/linux/kernel/1712.1/05692.html
>>>
>>> Thanks,
>>>
>>> -Jason
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

