Return-Path: <mst@redhat.com>
Date: Mon, 17 Jan 2022 16:30:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220117160951-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 17, 2022 at 11:56:09AM +0200, Max Gurtovoy wrote:
> 
> On 1/13/2022 7:53 PM, Michael S. Tsirkin wrote:
> > On Thu, Jan 13, 2022 at 04:50:59PM +0200, Max Gurtovoy wrote:
> > > In one of the many use cases a user wants to manipulate features and
> > > configuration of the virtio devices regardless of the device type
> > > (net/block/console). Some of this configuration is generic enough. i.e
> > > Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
> > > such features query and manipulation by its parent PCI PF.
> > > 
> > > Currently virtio specification defines control virtqueue to manipulate
> > > features and configuration of the device it operates on. However,
> > > control virtqueue commands are device type specific, which makes it very
> > > difficult to extend for device agnostic commands. Control virtqueue is
> > > also limited to follow in order completion for the device which
> > > negotiates VIRTIO_F_IN_ORDER feature. This feature limits the use of
> > > control virtqueue for feature manipulation in out of order manner for
> > > unrelated commands.
> > > 
> > > To support these requirements which overcome above two limitations in
> > > elegant way, this patch introduces a new admin virtqueue. Admin
> > > virtqueue will use the same command format for all types of virtio
> > > devices.
> > > 
> > > Subsequent patches make use of this admin virtqueue.
> > > 
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   admin-virtq.tex | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >   content.tex     |  9 +++++++--
> > >   2 files changed, 56 insertions(+), 2 deletions(-)
> > >   create mode 100644 admin-virtq.tex
> > > 
> > > diff --git a/admin-virtq.tex b/admin-virtq.tex
> > > new file mode 100644
> > > index 0000000..ad20f89
> > > --- /dev/null
> > > +++ b/admin-virtq.tex
> > > @@ -0,0 +1,49 @@
> > > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > +
> > > +Admin virtqueue is used to send administrative commands to manipulate
> > > +various features of the device which would not easily map into the
> > > +configuration space.
> > IMHO this is too vague to be useful. E.g. I don't really see
> > why would not commands specified in the next patch map to config space.
> 
> Well I took this sentence from the current spec :)

Well in current spec it applies to things like MAC address filtering,
which does not easily map into config space because number of MACs
varies.


> 
> > 
> > 
> > We had an off-list meeting where I proposed addressing one device
> > from another or grouping multiple devices as a more specific
> > scope. That would be one way to address this.
> 
> Are you suggestion a creation of a virtio subsystem or a virtio group
> definition ?
> 
> Devices will be part of this subsystem: one primary/manager device and many
> secondary/managed devices ?
> 
> Each subsystem will have a unique UUID and each device will have a unique
> vdev_id within this subsystem.
> 
> If this is the direction, I can prepare something..

I was merely saying that what is special about admin queue is that it
allows controlling one device from another within some group.
Or maybe that it allows grouping multiple devices.
*Not* that these are things that do not map to config space.

Let me give you another example, imagine that you want to handle
pagefaults from device.  Clearly a generic thing that does not map to
config space.  It could be a good candidate for the admin queue, however
it would require that lots of buffers are pre-added to the queue. So it
looks like it will beed another distinct fault queue.  Further it is
possible that you want to handle faults within guest, by the driver. In
that case you do not want it in the admin queue since that is controlled
by hypervisor, you want it in a separate queue controlled by driver.


I don't recall discussion about UUID so I can't really say what
I think about that. Do we need a UUID? I'm not sure I understand why.
It can't hurt to abstract things a bit so it's not all tied to
PFs/VFs since we know we'll want subfunctions down the road, too,
if that is what you mean.



> > 
> > Following this idea, all commands would then gain fields for addressing
> > one device from another.
> > 
> > Not everything maps well to a queue. E.g. it would be great to have
> > list of available commands in memory.
> 
> I'm not sure I agree. Why can't it map to a queue ?

You can map it to a queue, yes. But something static
and read only such as list of commands maps well to
config space. And it's not controlling one device from
another, so does not really seem to belong in the admin queue.

> 
> > Figuring out max vectors also looks like a good
> > example for memory and not through a command.
> 
> Any explanation why is it looks good ? or better ?

why is memory easier to operate than a VQ?
It's much simpler and so less error prone.  you can have multiple actors
read such a field at the same time without races, so e.g.  there could
be a sysfs attribute that reads from device on each access, and not
special error handling is needed.

> > VQ # of the admin VQ could also be made more discoverable.
> > How about an SRIOV capability describing this stuff then?
> > 
> > 
> > 
> > 
> > > +Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
> > > +feature bit.
> > > +
> > > +Admin virtqueue index may vary among different device types.
> > > +
> > > +The Admin command set defines the commands that may be issued only to the admin
> > > +virtqueue. Each virtio device that advertises the VIRTIO_F_ADMIN_VQ feature, MUST
> > > +support all the mandatory admin commands. A device MAY support also one or more
> > > +optional admin commands. All commands are of the following form:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd {
> > > +        /* Device-readable part */
> > > +        u8 command;
> > > +        u8 command-specific-data[];
> > > +
> > > +        /* Device-writable part */
> > > +        u8 status;
> > > +        u8 command-specific-result[];
> > > +};
> > > +
> > > +/* status values */
> > > +#define VIRTIO_ADMIN_STATUS_OK 0
> > > +#define VIRTIO_ADMIN_STATUS_ERR 1
> > > +#define VIRTIO_ADMIN_STATUS_COMMAND_UNSUPPORTED 2
> > > +\end{lstlisting}
> > > +
> > > +The \field{command} and \field{command-specific-data} are
> > > +set by the driver, and the device sets the \field{status} and the
> > > +\field{command-specific-result}, if needed.
> > > +
> > > +The following table describes the Admin command set:
> > > +
> > > +\begin{tabular}{|l|l|l|l|}
> > > +\hline
> > > +Opcode (bits) & Opcode (hex) & Command & M/O \\
> > > +\hline \hline
> > > + -  & 00h - 7Fh   & Generic admin cmds    & -  \\
> > > +\hline
> > > + -  & 80h - FFh   & Reserved    & - \\
> > > +\hline
> > > +\end{tabular}
> > > +
> > Add conformance clauses pls. If this section is too generic to have any then
> > this functionality is too generic to be useful ;)
> > 
> > > diff --git a/content.tex b/content.tex
> > > index 32de668..c524fab 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> > >   \begin{description}
> > >   \item[0 to 23] Feature bits for the specific device type
> > > -\item[24 to 40] Feature bits reserved for extensions to the queue and
> > > +\item[24 to 41] Feature bits reserved for extensions to the queue and
> > >     feature negotiation mechanisms
> > > -\item[41 and above] Feature bits reserved for future extensions.
> > > +\item[42 and above] Feature bits reserved for future extensions.
> > >   \end{description}
> > >   \begin{note}
> > > @@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
> > >   types. It is RECOMMENDED that devices generate version 4
> > >   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> > > +\input{admin-virtq.tex}
> > > +
> > >   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> > >   We start with an overview of device initialization, then expand on the
> > > @@ -6847,6 +6849,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >     that the driver can reset a queue individually.
> > >     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> > > +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that
> > > +  the device supports administration virtqueue negotiation.
> > > +
> > >   \end{description}
> > >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > -- 
> > > 2.21.0

