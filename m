Return-Path: <mst@redhat.com>
Date: Wed, 23 Nov 2022 05:00:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 8/9] admin: command list discovery
Message-ID: <20221123045930-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
 <87wn7ndna4.fsf@redhat.com>
 <20221122140607-mutt-send-email-mst@kernel.org>
 <87h6yqngm4.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87h6yqngm4.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 23, 2022 at 10:51:31AM +0100, Cornelia Huck wrote:
> On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Nov 22, 2022 at 04:25:23PM +0100, Cornelia Huck wrote:
> >> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > Using 0x instead of h suffix? Sure.
> >
> > We should probably document the syntax in introduction.tex
> > though this seems low priority.
> 
> Nod.
> >> > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
> >> > +the following table describes possible \field{status_qialifier} values:
> >> > +\begin{tabular}{|l|l|l|}
> >> > +\hline
> >> > +Status & Name & Description \\
> >> > +\hline \hline
> >> > +00h   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\
> >> 
> >> Either 0x00, or decimal (which one is better?)
> >
> > I think I prefer 0x here. And maybe I will add status values in both hex
> > and decimal (I used decimal to be consistent with linux headers but
> > fundamentally what we use most of the time is hex).
> 
> Ok.
> 
> >
> >> > +\hline
> >> > +01h   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> >> > +\hline
> >> > +02h   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> >> > +\hline
> >> > +03h   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} was set  \\
> >> 
> >> s/was set//
> >> 
> >> > +\hline
> >> > +04h   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \field{group_member_id} was set  \\
> >> 
> >> s/was set//
> >> 
> >> > +\hline
> >> > +other   & -    & group administration command error  \\
> >> 
> >> Again the question whether this is something that can be defined per
> >> group type.
> >
> > probably - above ones are generic, let's see if we need specific ones.
> > if yes will be easy to add.
> 
> I think we want to distinguish between "reserved" (not defined yet, may
> get a meaning later on) and "group type specific" (a group type may use
> it, don't reuse for generic stuff). If we need group type specific
> errors (and don't want a free-for-all), we could go with eg.
> 
> 0x05 & VIRTIO_ADMIN_STATUS_Q_GROUP_ERR_0 & group type specific error \\
> 
> or so? Do we see any need for that yet?

Not yet.

> >> > +The driver then enables use of some of the opcodes by sending to
> >> > +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> >> > +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> >> > +both understood and used by the driver.
> >> > +
> >> > +If the device supports the command list used by the driver, the
> >> > +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> >> > +If the device does not support the command list, the device
> >> > +completes the command with status
> >> > +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> >> > +
> >> > +Note: drivers are assumed not to set bits in device_admin_cmds
> >> > +if they are not familiar with how the command opcode
> >> > +is used, since devices could have dependencies between
> >> > +command opcodes.
> >> > +
> >> > +It is assumed that all members in a group support and are used
> >> > +with the same list of commands.
> >> 
> >> Can the driver later change its mind, i.e. use VIRTIO_ADMIN_CMD_LIST_USE
> >> a second time with a different set of commands? If yes, can it add
> >> commands, or only withdraw them?
> >
> > I think it's ok to allow changing them arbitrarily at any time.
> > If driver wants to "lock down" the list then all it has to do
> > is send a list with VIRTIO_ADMIN_CMD_LIST_USE cleared.
> >
> > It seemed clear along the lines of since it's not prohibited it's
> > allowed but since the question arose I will add a conformance clause for
> > this.
> 
> So if the driver sends LIST_USE with an additional command, and the
> device rejects that list (because of dependencies or whatever), is the
> list of commands supposed to stay whatever it was prior to that?

I think so, yes. Good point I'll document that.


> >
> >
> >> What happens if a driver tries to send a command that it had not
> >> included in the list?
> >
> >
> > This is covered in conformance statements in the next patch.
> >
> > +
> > +Device MUST validate commands against the list used by
> > +driver and MUST fail any commands not in the list with
> > +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +and \field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> 
> Ok.

