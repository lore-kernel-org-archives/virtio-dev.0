Return-Path: virtio-dev-return-4741-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7371985C99
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Jul 2018 20:24:41 +0000 (UTC)
MIME-Version: 1.0
In-Reply-To: <20180726104826.4c9f4a9c.cohuck@redhat.com>
References: <1532365355-45245-1-git-send-email-sridhar.samudrala@intel.com>
 <20180724144351.5f8dd113.cohuck@redhat.com> <CADGSJ23NDB20W3AW7K+G6Ap_g3WWSdibE51=Mga5E2XVNeW2BQ@mail.gmail.com>
 <20180726104826.4c9f4a9c.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 26 Jul 2018 13:24:38 -0700
Message-ID: <CADGSJ22jEj0AmSD0u5KbP+ZRLXrgQpdCmVrnXSC+JBTK4jdQBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [PATCH v2] content: Introduce
 VIRTIO_NET_F_STANDBY feature
To: Cornelia Huck <cohuck@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 26, 2018 at 1:48 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Wed, 25 Jul 2018 16:31:05 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Tue, Jul 24, 2018 at 5:43 AM, Cornelia Huck <cohuck@redhat.com> wrote:
>> > On Mon, 23 Jul 2018 10:02:35 -0700
>> > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>> >
>> >> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
>> >> device to act as a standby for a primary device with the same MAC address.
>> >>
>> >> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
>> >> ---
>> >>  content.tex | 8 ++++++++
>> >>  1 file changed, 8 insertions(+)
>> >>
>> >> v2: updated standby description based on Cornelia's feedback.
>> >>
>> >> diff --git a/content.tex b/content.tex
>> >> index be18234..b729857 100644
>> >> --- a/content.tex
>> >> +++ b/content.tex
>> >> @@ -2525,6 +2525,9 @@ features.
>> >>
>> >>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>> >>      channel.
>> >> +
>> >> +\item[VIRTIO_NET_F_STANDBY(62)] Device MAY act as a standby for a primary
>> >> +    device with the same MAC
>> >
>> > I don't think you should use MAY etc. outside a normative section, so
>> > s/MAY/may/
>> >
>> >>  \end{description}
>> >>
>> >>  \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
>> >> @@ -2636,6 +2639,11 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
>> >>  size exceeding the value of \field{mtu} (plus low level ethernet header length)
>> >>  with \field{gso_type} NONE or ECN.
>> >>
>> >> +A driver SHOULD negotiate VIRTIO_NET_F_STANDBY feature if the device offers it.
>> >
>> > s/VIRTIO_NET_F_STANDBY feature/the VIRTIO_NET_F_STANDBY feature/
>> >
>> >> +
>> >> +If the driver negotiates VIRTIO_NET_F_STANDBY, the device MAY act as a standby
>> >> +device for a primary device with the same MAC address.
>> >
>> > I think the first statement needs to go into a driver normative
>> > section, while the second needs to go into a device normative section.
>> >
>> >> +
>> >>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>> >>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>> >>  When using the legacy interface, transitional devices and drivers
>> >
>> > I still think we need a more detailed description of how this is
>> > supposed to work elsewhere (i.e., outside of the normative section).
>> > But we can probably merge an updated version of this patch to get at
>> > least the feature bit reserved and documented. Thoughts?
>>
>> I don't understand the purpose of this spec. Nothing has been
>> discussed and described beyond the current guest implementation.
>
> That's exactly the purpose of this update: Define what is actually the
> de facto meaning of the new feature bit.
>
>> Formerly I would expect to see more descriptions on the device side
>> behaviour: how primary device may or may not get exposed depending on
>> feature negotiation result of the standby device, how the primary
>> device may behave or get exposed if the driver for standby virtio
>> initiates a device reset, et al.  But from the last discussion I got
>> the impression that the host-guest interface is frozen whenever the
>> guest implementation is shipped and that behaviour becomes the spec.
>> Currently the guest implementation in Linux 4.18 is to NOT interact
>> with device side for anything during feature negotiaion. I don't see
>> what needs to be merged for an updated version. The current
>> VIRTIO_NET_F_STANDBY is irrelevant to anything in the device side, so
>> what needs to be reserved?
>
> It is *not* irrelevant to the device side: If a device offers the
> feature bit, it might trigger behaviour in the guest (i.e. looking for
> a device with a matching MAC address).

That is still guest side of the reaction not host side specifically,
and you cannot get QEMU side going without making further guest
changes IMHO. That's what I said the guest implementation is
currently incomplete - I wonder how possible it is to make further
QEMU change without updating any guest behaviour. Essentially this
spec would only work with libvirt manages exposure of primary device
not QEMU.

-Siwei



> As soon as you have a feature
> bit, the device and the driver *are* interacting.
>
> This is just specifying the minimum needed to make sure that
> implementations in the host are not making existing code out of spec.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

