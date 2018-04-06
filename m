Return-Path: virtio-dev-return-3742-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 43F8B58191B8
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Apr 2018 14:29:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403160834.51594373@xeon-e3>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-3-git-send-email-si-wei.liu@oracle.com> <20180403103536.6ec1450c@xeon-e3>
 <CADGSJ23vZdtQzWdc_6M_Hr4MUej--wgvJ785DwRF3VaPWS1rpA@mail.gmail.com> <20180403160834.51594373@xeon-e3>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 6 Apr 2018 14:29:38 -0700
Message-ID: <CADGSJ20-FTS0LAOUzpjhDcit1uAEQQs9yK_fGKDNqeRdBwe=3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Duyck <alexander.h.duyck@intel.com>, David Miller <davem@davemloft.net>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, si-wei liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

(put discussions back on list which got accidentally removed)

On Tue, Apr 3, 2018 at 4:08 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 3 Apr 2018 12:04:38 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Tue, Apr 3, 2018 at 10:35 AM, Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>> > On Sun,  1 Apr 2018 05:13:09 -0400
>> > Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> >
>> >> Hidden netdevice is not visible to userspace such that
>> >> typical network utilites e.g. ip, ifconfig and et al,
>> >> cannot sense its existence or configure it. Internally
>> >> hidden netdev may associate with an upper level netdev
>> >> that userspace has access to. Although userspace cannot
>> >> manipulate the lower netdev directly, user may control
>> >> or configure the underlying hidden device through the
>> >> upper-level netdev. For identification purpose, the
>> >> kobject for hidden netdev still presents in the sysfs
>> >> hierarchy, however, no uevent message will be generated
>> >> when the sysfs entry is created, modified or destroyed.
>> >>
>> >> For that end, a separate namescope needs to be carved
>> >> out for IFF_HIDDEN netdevs. As of now netdev name that
>> >> starts with colon i.e. ':' is invalid in userspace,
>> >> since socket ioctls such as SIOCGIFCONF use ':' as the
>> >> separator for ifname. The absence of namescope started
>> >> with ':' can rightly be used as the namescope for
>> >> the kernel-only IFF_HIDDEN netdevs.
>> >>
>> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> >> ---
>> >
>> > I understand the use case. I proposed using . as a prefix before
>> > but that ran into resistance. Using colon seems worse.
>>
>> Using dot (.) can't be good because it would cause namespace collision
>> and thus breaking apps when you hide the device. Imagine a user really
>> wants to add a link with the same name as the one hidden and it starts
>> with a dot. It would fail, and users don't know its just because the
>> name starts with dot. IMHO users should be agnostic of (the namespace
>> of) hidden device at all if what they pick is a valid name.
>>
>> ":" is an invalid prefix to userspace, there's no such problem if
>> being used to construct the namescope for hidden devices.
>>
>> However, technically, just as what I alluded to in the reply earlier,
>> it might really be consistent to put this under a separeate namespace
>> instead than fiddling with name prefix. But I am just not sure if that
>> is a big hammer and would like to earn enough feedback and attention
>> before going that way too quickly.
>>
>>
>> >
>> > Rather than playing with names and all the issues that can cause,
>> > why not make it an attribute flag of the device in netlink.
>>
>> Atrribute flag doesn't help. It's a matter of namespace.
>>
>> Regards,
>> -Siwei
>
> In Vyatta, we used names like ".isatap" for devices that would clutter up
> the user experience. They are naturally not visible by simple scans of
> /sys/class/net, and there was a patch to ignore them in iproute2.
> It was a hack which worked but not really worth upstreaming.
>
> The question is if this a security feature then it needs to be more

I don't expect the namespace to be a security aspect of feature, but
rather a way to make old userspace unmodified  to work with a new
feature. And, we're going to add API to expose the netdev info for the
invisible IFF_AUTO_MANAGED links anyway. We don't need to make it
secure and all hidden under the dark to be honest.

> robust than just name prefix. Plus it took years to handle network
> namespaces everywhere; this kind of flag would start same problems.
>
> Network namespaces work but have the problem namespaces only weakly
> support hierarchy and nesting. I prefer the namespace approach
> because it fits better and has less impact.

Great, thanks!

-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

