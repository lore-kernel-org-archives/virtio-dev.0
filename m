Return-Path: virtio-dev-return-3697-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C92AB5818DC6
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Apr 2018 00:41:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-3-git-send-email-si-wei.liu@oracle.com> <8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Tue, 3 Apr 2018 00:40:50 -0700
Message-ID: <CADGSJ23tSSo8WmGCmhWPFapXpW=c_A0_qpYH4r6fb9NEnzsnsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: David Ahern <dsahern@gmail.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, David Miller <davem@davemloft.net>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Apr 1, 2018 at 9:11 AM, David Ahern <dsahern@gmail.com> wrote:
> On 4/1/18 3:13 AM, Si-Wei Liu wrote:
>> Hidden netdevice is not visible to userspace such that
>> typical network utilities e.g. ip, ifconfig and et al,
>> cannot sense its existence or configure it. Internally
>> hidden netdev may associate with an upper level netdev
>> that userspace has access to. Although userspace cannot
>> manipulate the lower netdev directly, user may control
>> or configure the underlying hidden device through the
>> upper-level netdev. For identification purpose, the
>> kobject for hidden netdev still presents in the sysfs
>> hierarchy, however, no uevent message will be generated
>> when the sysfs entry is created, modified or destroyed.
>>
>> For that end, a separate namescope needs to be carved
>> out for IFF_HIDDEN netdevs. As of now netdev name that
>> starts with colon i.e. ':' is invalid in userspace,
>> since socket ioctls such as SIOCGIFCONF use ':' as the
>> separator for ifname. The absence of namescope started
>> with ':' can rightly be used as the namescope for
>> the kernel-only IFF_HIDDEN netdevs.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>  include/linux/netdevice.h   |  12 ++
>>  include/net/net_namespace.h |   2 +
>>  net/core/dev.c              | 281 ++++++++++++++++++++++++++++++++++++++------
>>  net/core/net_namespace.c    |   1 +
>>  4 files changed, 263 insertions(+), 33 deletions(-)
>>
>
> There are other use cases that want to hide a device from userspace.

Can you elaborate your case in more details? Looking at the links
below I realize that the purpose of hiding devices in your case is
quite different from the our migration case. Particularly, I don't
like the part of elaborately allowing user to manipulate the link's
visibility - things fall apart easily while live migration is on
going. And, why doing additional check for invisible links in every
for_each_netdev() and its friends. This is effectively changing
semantics of internal APIs that exist for decades.

> I would prefer a better solution than playing games with name prefixes and

This part is intentionally left to be that way and I would anticipate
feedback before going too far. The idea in my mind was that I need a
completely new device namespace underneath (or namescope, which is !=
netns) for all netdevs: kernel-only IFF_HIDDEN network devices and
those not. The current namespace for devname is already exposed to
userspace and visible in the sysfs hierarchy, but for backwards
compatibility reasons it's necessary to keep the old udevd still able
to reference the entry of IFF_HIDDEN netdev under the /sys/net
directory. By using the ':' prefix it has the benefit of minimal
changes without introducing another namespace or the accompanied
complexity in managing these two separate namespaces.

Technically, I can create a separate sysfs directory for the new
namescope, say /sys/net-kernel, which includes all netdev entries like
':eth0' and 'ens3', and which can be referenced from /sys/net. It
would make the /sys/net consistent with the view of userspace
utilities, but I am not even sure if that's an overkill, and would
like to gather more feedback before moving to that model.

> one that includes an API for users to list all devices -- even ones

What kind of API you would like to query for hidden devices?
rtnetlink? a private socket API? or something else?

For our case, the sysfs interface is what we need and is sufficient,
since udev is the main target we'd like to support to make the naming
of virtio_bypass consistent and compatible.

> hidden by default.
>
> https://github.com/dsahern/linux/commit/48a80a00eac284e58bae04af10a5a932dd7aee00
>
> https://github.com/dsahern/iproute2/commit/7563f5b26f5539960e99066e34a995d22ea908ed
>
> Also, why are you suggesting that the device should still be visible via
> /sysfs? That leads to inconsistent views of networking state - /sys
> shows a device but a link dump does not.

See my clarifications above. I don't mind kernel-only netdevs being
visible via sysfs, as that way we get a good trade-off between
backwards compatibility and visibility. There's still kobject created
there right. Bottom line is that all kernel devices and its life-cycle
uevents are made invisible to userpace network utilities, and I think
it simply gets to the goal of not breaking existing apps while being
able to add new features.

-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

