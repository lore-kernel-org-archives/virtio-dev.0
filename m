Return-Path: <mst@redhat.com>
Date: Wed, 18 May 2022 19:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 3/7] Introduce new destination type for admin commands
Message-ID: <20220518195237-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-4-mgurtovoy@nvidia.com>
 <20220515110536-mutt-send-email-mst@kernel.org>
 <1491ba9a-fb0f-9dba-337c-6ecbf573fad3@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1491ba9a-fb0f-9dba-337c-6ecbf573fad3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 18, 2022 at 05:34:33PM +0300, Max Gurtovoy wrote:
> 
> On 5/15/2022 6:09 PM, Michael S. Tsirkin wrote:
> > On Wed, Apr 27, 2022 at 01:58:20AM +0300, Max Gurtovoy wrote:
> > > Introduce a new mechanism to issue commands with dst_type field that is
> > > not "self". With the new mechanism, driver can set dst_type to 1
> > > and use the vdev_id common field to describe the designated vdev_id.
> > > 
> > > This mechanism is useful for device groups with multiple devices
> > > with various different capabilities. For example, a type 1 device group
> > > that contains a PCI PF and its VF. For this group, a clever system
> > > administrator can use admin commands to manipulate the PF/VF resources.
> > > 
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   admin.tex | 18 ++++++++++++++----
> > >   1 file changed, 14 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/admin.tex b/admin.tex
> > > index 6725daa..f816c3b 100644
> > > --- a/admin.tex
> > > +++ b/admin.tex
> > > @@ -11,11 +11,13 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
> > >           le16 command;
> > >           /*
> > >            * 0 - self
> > > -         * 1 - 65535 are reserved
> > > +         * 1 - other virtio device (identified by vdev_id) in the same device group
> > > +         * 2 - 65535 are reserved
> > >            */
> > >           le16 dst_type;
> > > +        le64 vdev_id;
> > Alignment problems. Proposal:
> > 
> > vdev_id
> > dst_type
> > command
> 
> I don't understand what is the issue here. All sw-hw packets should be
> __packed__

No and most virtio ones are not.

> why should I change the order to be something that is not intuitive ?

packed structs often cause compiler to generate horrible code.
so we generally don't do this. in some cases we made a mistake
and stick to it for now. don't copy that.

> > 
> > 
> > >           /* reserved for common cmd fields */
> > > -        u8 reserved[20];
> > > +        u8 reserved[12];
> > >           u8 command_specific_data[];
> > >           /* Device-writable part */
> > 
> > > @@ -39,9 +41,11 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
> > >   \hline
> > >   03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
> > >   \hline
> > > +04h   & VIRTIO_ADMIN_STATUS_INVALID_VDEV_ID    & invalid vdev_id was set  \\
> > > +\hline
> > >   \end{tabular}
> > > -The \field{command}, \field{dst_type} and \field{command_specific_data} are
> > > +The \field{command}, \field{dst_type}, \field{vdev_id} and \field{command_specific_data} are
> > >   set by the driver, and the device sets the \field{status}, the
> > >   \field{command_specific_error} and the \field{command_specific_result},
> > >   if needed.
> > > @@ -50,9 +54,15 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
> > >   The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
> > > +The optional unused fields to be zeroed by the driver.
> > > +
> > >   The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
> > > -The \field{dst_type} defines the designated virtio device for the command. This value should be set to 0 (self).
> > > +The \field{dst_type} defines the designated virtio device for the command. This value can be set to 0 (self) or 1 (other virtio device in the same device
> > > +group) by the driver. Not all the commands allow setting \field{dst_type} to 1. Refer to each command description explicitly to check whether this operation is allowed.
> > > +If \field{dst_type} is set to 0 by the driver, the \field{vdev_id} isn't valid, should be zeroed by the driver and should be ignored by the device.
> > > +If \field{dst_type} is set to 1 by the driver, the \field{vdev_id} is valid and used to describe the vdev_id of the designated virtio device (see section
> > > +\ref{sec:Introduction / Terminology / Device group} for vdev_id numbering for type 1 device groups).
> > >   The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
> > >   VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
> > 
> > teminology is a bit inconsistent. would dst_id be better? it goes
> > together with dst_type after all.
> 
> I don't think dst_id is better than vdev_id. Sorry.
> 
> vdev_id is a unique identifier of a device inside a device group.

- no consistency with dst_type
- v in "vdev" is pointless
- does not tell you which device it is. source sending command?
  destination to which it refers?

> > 
> > > -- 
> > > 2.21.0

