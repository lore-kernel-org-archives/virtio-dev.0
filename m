Return-Path: virtio-dev-return-3762-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A387358191E6
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Apr 2018 15:07:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180407031919.GB11029@lunn.ch>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
 <CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
 <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com> <20180404.133749.1802514210170809419.davem@davemloft.net>
 <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com> <20180407031919.GB11029@lunn.ch>
From: Siwei Liu <loseweigh@gmail.com>
Date: Mon, 9 Apr 2018 15:07:26 -0700
Message-ID: <CADGSJ211kA5ktADbwv2f4ma_ooBmYW4r7YwzGD2G_Gw5+wv5rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>, Jiri Pirko <jiri@resnulli.us>, si-wei liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 6, 2018 at 8:19 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Siwei
>
>> I think everyone seems to agree not to fiddle with the ":" prefix, but
>> rather have a new class of network subsystem under /sys/class thus a
>> separate device namespace e.g. /sys/class/net-kernel for those
>> auto-managed lower netdevs is needed.
>
> How do you get a device into this new class? I don't know the Linux
> driver model too well, but to get a device out of one class and into
> another, i think you need to device_del(dev). modify dev->class and
> then device_add(dev). However, device_add() says you are not allowed
> to do this.

No, implementation wise I'd avoid changing the class on the fly. What
I'm looking to is a means to add a secondary class or class aliasing
mechanism for netdevs that allows mapping for a kernel device
namespace (/class/net-kernel) to userspace (/class/net). Imagine
creating symlinks between these two namespaces as an analogy. All
userspace visible netdevs today will have both a kernel name and a
userspace visible name, having one (/class/net) referecing the other
(/class/net-kernel) in its own namespace. The newly introduced
IFF_AUTO_MANAGED device will have a kernel name only
(/class/net-kernel). As a result, the existing applications using
/class/net don't break, while we're adding the kernel namespace that
allows IFF_AUTO_MANAGED devices which will not be exposed to userspace
at all.

As this requires changing the internals of driver model core it's a
rather big hammer approach I'd think. If there exists a better
implementation than this to allow adding a separate layer of in-kernel
device namespace, I'd more than welcome to hear about.

>
> And i don't even see how this helps. Are you also not going to call
> list_netdevice()? Are you going to add some other list for these
> devices in a different class?

list_netdevice() is still called. I think with the current RFC patch,
I've added two lists for netdevs under the kernel namespace:
dev_cmpl_list and name_cmpl_hlist. As a result of that, all userspace
netdevs get registered will be added to two types of lists: the
userspace list for e.g. dev_list, and also the kernelspace list e.g.
dev_cmpl_list (I can rename it to something more accurate). The
IFF_AUTO_MANAGED device will be only added to kernelspace list e.g.
dev_cmpl_list.

Hope all your questions are answered.

Thanks,
-Siwei


>
>    Andrew

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

