Return-Path: virtio-dev-return-3716-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F9F55819049
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Apr 2018 00:36:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-3-git-send-email-si-wei.liu@oracle.com> <8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
 <20180403154210.GK3313@nanopsycho> <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 4 Apr 2018 00:36:34 -0700
Message-ID: <CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: David Ahern <dsahern@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, David Miller <davem@davemloft.net>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 3, 2018 at 6:04 PM, David Ahern <dsahern@gmail.com> wrote:
> On 4/3/18 9:42 AM, Jiri Pirko wrote:
>>>
>>> There are other use cases that want to hide a device from userspace. I
>>
>> What usecases do you have in mind?
>
> As mentioned in a previous response some kernel drivers create control
> netdevs. Just as in this case users should not be mucking with it, and
> S/W like lldpd should ignore it.
>
>>
>>> would prefer a better solution than playing games with name prefixes and
>>> one that includes an API for users to list all devices -- even ones
>>> hidden by default.
>>
>> Netdevice hiding feels a bit scarry for me. This smells like a workaround
>> for userspace issues. Why can't the netdevice be visible always and
>> userspace would know what is it and what should it do with it?
>>
>> Once we start with hiding, there are other things related to that which
>> appear. Like who can see what, levels of visibility etc...
>>
>
> I would not advocate for any API that does not allow users to have full
> introspection. The intent is to hide the netdev by default but have an
> option to see it.

I'm fine with having a link dump API to inspect the hidden netdev. As
said, the name for hidden netdevs should be in a separate device
namespace, and we did not even get closer to what it should look like
as I don't want to make it just an option for ip link. Perhaps a new
set of sub-commands of, say, 'ip device'.

-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

