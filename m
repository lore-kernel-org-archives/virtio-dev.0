Return-Path: <mst@redhat.com>
Date: Wed, 23 Nov 2022 05:16:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 8/9] admin: command list discovery
Message-ID: <20221123051414-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
 <87wn7ndna4.fsf@redhat.com>
 <20221122140607-mutt-send-email-mst@kernel.org>
 <87h6yqngm4.fsf@redhat.com>
 <20221123045930-mutt-send-email-mst@kernel.org>
 <878rk2nfs9.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <878rk2nfs9.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 23, 2022 at 11:09:26AM +0100, Cornelia Huck wrote:
> On Wed, Nov 23 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Nov 23, 2022 at 10:51:31AM +0100, Cornelia Huck wrote:
> >> On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Tue, Nov 22, 2022 at 04:25:23PM +0100, Cornelia Huck wrote:
> >> >> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
> >> >> > +the following table describes possible \field{status_qialifier} values:
> >> >> > +\begin{tabular}{|l|l|l|}
> >> >> > +\hline
> >> >> > +Status & Name & Description \\
> >> >> > +\hline \hline
> >> >> > +00h   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\
> >> >> 
> >> >> Either 0x00, or decimal (which one is better?)
> >> >
> >> > I think I prefer 0x here. And maybe I will add status values in both hex
> >> > and decimal (I used decimal to be consistent with linux headers but
> >> > fundamentally what we use most of the time is hex).
> >> 
> >> Ok.
> >> 
> >> >
> >> >> > +\hline
> >> >> > +01h   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> >> >> > +\hline
> >> >> > +02h   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> >> >> > +\hline
> >> >> > +03h   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} was set  \\
> >> >> 
> >> >> s/was set//
> >> >> 
> >> >> > +\hline
> >> >> > +04h   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \field{group_member_id} was set  \\
> >> >> 
> >> >> s/was set//
> >> >> 
> >> >> > +\hline
> >> >> > +other   & -    & group administration command error  \\
> >> >> 
> >> >> Again the question whether this is something that can be defined per
> >> >> group type.
> >> >
> >> > probably - above ones are generic, let's see if we need specific ones.
> >> > if yes will be easy to add.
> >> 
> >> I think we want to distinguish between "reserved" (not defined yet, may
> >> get a meaning later on) and "group type specific" (a group type may use
> >> it, don't reuse for generic stuff). If we need group type specific
> >> errors (and don't want a free-for-all), we could go with eg.
> >> 
> >> 0x05 & VIRTIO_ADMIN_STATUS_Q_GROUP_ERR_0 & group type specific error \\
> >> 
> >> or so? Do we see any need for that yet?
> >
> > Not yet.
> 
> Then maybe let's make the last line
> 
> 0x05 - & - & reserved for future use \\
> 
> ?

Hmm 5 is reserved but anything else is a generic error. I'm not sure
what the difference is. Could you clarify? E.g. how will driver handle
such an error if it gets it? Is it an error to get a reserved error
value?

-- 
MST

