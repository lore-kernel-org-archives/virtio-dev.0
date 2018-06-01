Return-Path: virtio-dev-return-4262-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D7C45818E8A
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Jun 2018 14:29:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180602000131-mutt-send-email-mst@kernel.org>
References: <20180523151613.3914-1-venu.busireddy@oracle.com>
 <20180601184033-mutt-send-email-mst@kernel.org> <20180601170126.GA10908@vbusired-vm>
 <20180601230119-mutt-send-email-mst@kernel.org> <CADGSJ23JMOVdpfQVoR-q4NKqy0aGwVNX8L7iHYssuStqSfMM9A@mail.gmail.com>
 <20180602000131-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 1 Jun 2018 14:29:09 -0700
Message-ID: <CADGSJ20pwBPNPd74yaNVwkQA1M7trkBmy=oC6HEBjQS=tk0=2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH 0/1] Add "Group Identifier" to virtio PCI capabilities.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 1, 2018 at 2:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Jun 01, 2018 at 01:36:34PM -0700, Siwei Liu wrote:
>> On Fri, Jun 1, 2018 at 1:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Fri, Jun 01, 2018 at 12:01:26PM -0500, Venu Busireddy wrote:
>> >> On 2018-06-01 18:42:06 +0300, Michael S. Tsirkin wrote:
>> >> > On Wed, May 23, 2018 at 11:16:12AM -0400, Venu Busireddy wrote:
>> >> > > During live migration involving passthrough devices, the guest needs
>> >> > > to know which virtio device will be a fail-over device for a given
>> >> > > passthrough device.
>> >> > >
>> >> > > Extending the virtio specification with a new "Group Identifier"
>> >> > > capability allows qemu to set up the grouping at the time the guest
>> >> > > is created. The "Group Identifier" can be as simple as a number, or an
>> >> > > UUID. The driver can use the group identifier to pair the virtio device
>> >> > > with the passthrough device. The passthrough device can contain the
>> >> > > group identifier in the PCIe bridge to which it is attached.
>> >> > >
>> >> > > Venu Busireddy (1):
>> >> > >   Add "Group Identifier" to virtio PCI capabilities.
>> >> > >
>> >> > >  content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
>> >> > >  1 file changed, 43 insertions(+)
>> >> >
>> >> > Is this a PCI thing, or can this somehow be used with non-PCI
>> >>
>> >> This is applicable to all virtio PCI devices, but not to non-PCI
>> >> devices.
>> >>
>> >> > devices? If PCI, we can just add a PCI UUID capability to
>> >> > virtio without need to worry about the spec.
>> >>
>> >> What is a "PCI UUID capability?" "PCI Local Bus Specification
>> >> Revision 3.0, Appendix H" does not list any such capability.
>> >>
>> >> Regards,
>> >>
>> >> Venu
>> >
>> > Sorry that I'm unclear. What I meant is the
>> > PCI Express serial number capability (0003h).
>>
>> Then what's on legacy PCI bridge device with i440fx chipset? VPD capability?
>
> Or just limit this to Express.
> At this point main benefit of legacy PCI is to support legacy virtio
> and that won't support this new feature.

The legacy i440fx model might already exist for a while that I'd fear
switching to Q35 over night for those existing setups would perhaps
not be practical. And they might be using transitional virtio device
by default meaning that new features get exposed immediately once
added. I would think for completeness and transition point of view
there's still some sense to support legacy PCI bridge, no?

-Siwei


>
>> >
>> > --
>> > MST
>> >
>> > ---------------------------------------------------------------------
>> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

