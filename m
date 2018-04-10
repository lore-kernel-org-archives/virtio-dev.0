Return-Path: virtio-dev-return-3772-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2550958191F8
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Apr 2018 23:49:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180408.123207.2294740686493951200.davem@davemloft.net>
References: <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
 <20180404.133749.1802514210170809419.davem@davemloft.net> <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
 <20180408.123207.2294740686493951200.davem@davemloft.net>
From: Siwei Liu <loseweigh@gmail.com>
Date: Mon, 9 Apr 2018 23:48:52 -0700
Message-ID: <CADGSJ233AmbBrTP-A_u3-5fkr=HUJka_xcSNWxO1HWGua1J92Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: David Miller <davem@davemloft.net>
Cc: David Ahern <dsahern@gmail.com>, Jiri Pirko <jiri@resnulli.us>, si-wei liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Apr 8, 2018 at 9:32 AM, David Miller <davem@davemloft.net> wrote:
> From: Siwei Liu <loseweigh@gmail.com>
> Date: Fri, 6 Apr 2018 19:32:05 -0700
>
>> And I assume everyone here understands the use case for live
>> migration (in the context of providing cloud service) is very
>> different, and we have to hide the netdevs. If not, I'm more than
>> happy to clarify.
>
> I think you still need to clarify.

OK. The short answer is cloud users really want *transparent* live migration.

By being transparent it means they don't and shouldn't care about the
existence and the occurence of live migration, but they do if
userspace toolstack and libraries have to be updated or modified,
which means potential dependency brokeness of their applications. They
don't like any change to the userspace envinroment (existing apps
lift-and-shift, no recompilation, no re-packaging, no re-certification
needed), while no one barely cares about ABI or API compatibility in
the kernel level, as long as their applications don't break.

I agree the current bypass solution for SR-IOV live migration requires
guest cooperation. Though it doesn't mean guest *userspace*
cooperation. As a matter of fact, techinically it shouldn't invovle
userspace at all to get SR-IOV migration working. It's the kernel that
does the real work. If I understand the goal of this in-kernel
approach correctly, it was meant to save userspace from modification
or corresponding toolstack support, as those additional 2 interfaces
is more a side product of this approach, rather than being neccessary
for users to be aware of. All what the user needs to deal with is one
single interface, and that's what they care about. It's more a trouble
than help when they see 2 extra interfaces are present. Management
tools in the old distros don't recoginze them and try to bring up
those extra interfaces for its own. Various odd warnings start to spew
out, and there's a lot of caveats for the users to get around...

On the other hand, if we "teach" those cloud users to update the
userspace toolstack just for trading a feature they don't need, no one
is likely going to embrace the change. As such there's just no real
value of adopting this in-kernel bypass facility for any cloud service
provider. It does not look more appealing than just configure generic
bonding using its own set of daemons or scripts. But again, cloud
users don't welcome that facility. And basically it would get to
nearly the same set of problems if leaving userspace alone.

IMHO we're not hiding the devices, think it the way we're adding a
feature transparent to user. Those auto-managed slaves are ones users
don't care about much. And user is still able to see and configure the
lower netdevs if they really desires to do so. But generally the
target user for this feature won't need to know that. Why they care
how many interfaces a VM virtually has rather than how many interfaces
are actually _useable_ to them??

Thanks,
-Siwei


>
> netdevs are netdevs.  If they have special attributes, mark them as
> such and the tools base their actions upon that.
>
> "Hiding", or changing classes, doesn't make any sense to me still.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

