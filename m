Return-Path: virtio-dev-return-3764-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A3445818F75
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Apr 2018 16:31:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180409160348.12f8a6d9@xeon-e3>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
 <CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
 <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com> <20180404.133749.1802514210170809419.davem@davemloft.net>
 <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
 <20180407031919.GB11029@lunn.ch> <CADGSJ211kA5ktADbwv2f4ma_ooBmYW4r7YwzGD2G_Gw5+wv5rw@mail.gmail.com>
 <20180409221523.GH562@lunn.ch> <CADGSJ23RnioMdi0U0yeOBKuM-9QUZ3S33as693xzs0VWQbuVcA@mail.gmail.com>
 <20180409160348.12f8a6d9@xeon-e3>
From: Siwei Liu <loseweigh@gmail.com>
Date: Mon, 9 Apr 2018 16:31:50 -0700
Message-ID: <CADGSJ21_MRJwjMRyLMBLJ=BFM9thEvSwBtyutNXcW=RtmJJ3Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>, Jiri Pirko <jiri@resnulli.us>, si-wei liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@intel.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Apr 9, 2018 at 4:03 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Mon, 9 Apr 2018 15:30:42 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Mon, Apr 9, 2018 at 3:15 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> >> No, implementation wise I'd avoid changing the class on the fly. What
>> >> I'm looking to is a means to add a secondary class or class aliasing
>> >> mechanism for netdevs that allows mapping for a kernel device
>> >> namespace (/class/net-kernel) to userspace (/class/net). Imagine
>> >> creating symlinks between these two namespaces as an analogy. All
>> >> userspace visible netdevs today will have both a kernel name and a
>> >> userspace visible name, having one (/class/net) referecing the other
>> >> (/class/net-kernel) in its own namespace. The newly introduced
>> >> IFF_AUTO_MANAGED device will have a kernel name only
>> >> (/class/net-kernel). As a result, the existing applications using
>> >> /class/net don't break, while we're adding the kernel namespace that
>> >> allows IFF_AUTO_MANAGED devices which will not be exposed to userspace
>> >> at all.
>> >
>> > My gut feeling is this whole scheme will not fly. You really should be
>> > talking to GregKH.
>>
>> Will do. Before spreading it out loudly I'd run it within netdev to
>> clarify the need for why not exposing the lower netdevs is critical
>> for cloud service providers in the face of introducing a new feature,
>> and we are not hiding anything but exposing it in a way that don't
>> break existing userspace applications while introducing feature is
>> possible with the limitation of keeping old userspace still.
>>
>> >
>> > Anyway, please remember that IFF_AUTO_MANAGED will need to be dynamic.
>> > A device can start out as a normal device, and will change to being
>> > automatic later, when the user on top of it probes.
>>
>> Sure. In whatever form it's still a netdev, and changing the namespace
>> should be more dynamic than changing the class.
>>
>> Thanks a lot,
>> -Siwei
>>
>> >
>> >         Andrew
>
> Also, remember for netdev's /sys is really a third class API.
> The primary API's are netlink and ioctl. Also why not use existing
> network namespaces rather than inventing a new abstraction?

Because we want to leave old userspace unmodified while making SR-IOV
live migration transparent to users. Specifically, we'd want old udevd
to skip through uevents for the lower netdevs, while also making new
udevd able to name the bypass_master interface by referencing the pci
slot information which is only present in the sysfs entry for
IFF_AUTO_MANAGED net device.

The problem of using network namespace is that, no sysfs entry will be
around for IFF_AUTO_MANAGED netdev if we isolate it out to a separate
netns, unless we generalize the scope for what netns is designed for
(isolation I mean). For auto-managed netdevs we don't neccessarily
wants strict isolation, but rather a way of sticking to 1-netdev model
for strict backward compatibility requiement of the old userspace,
while exposing the information in a way new userspace understands.

Thanks,
-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

