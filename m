Return-Path: <virtio-comment-return-3098-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 3 Jun 2022 09:08:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YpnBi++zhJ/lXhDk@stefanha-x1.localdomain>
References: <20220601235559.41091-1-dmitry.fomichev@wdc.com>
 <Yphlet2cKT9ySAay@stefanha-x1.localdomain>
 <bf9ea224c637ce7f202418359ac96a6a182f45bb.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BApgZ1ROK/JCnqDv"
Content-Disposition: inline
In-Reply-To: <bf9ea224c637ce7f202418359ac96a6a182f45bb.camel@wdc.com>
Subject: [virtio-comment] Re: [virtio-dev] [RFC PATCH] virtio-blk: add zoned block device
 specification
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, "hare@suse.de" <hare@suse.de>, "its@irrelevant.dk" <its@irrelevant.dk>, Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, "faithilikerun@gmail.com" <faithilikerun@gmail.com>, "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>, "stefanha@gmail.com" <stefanha@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--BApgZ1ROK/JCnqDv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Resent from my subscriber email.)

On Fri, 3 Jun 2022 at 03:30, Dmitry Fomichev <Dmitry.Fomichev@wdc.com> wrot=
e:
>
> On Thu, 2022-06-02 at 08:23 +0100, Stefan Hajnoczi wrote:
> > (Resending from my mailing list subscriber address so this makes it onto
> > the list.)
> >
> > On Thu, 2 Jun 2022 at 00:56, Dmitry Fomichev <dmitry.fomichev@wdc.com> =
wrote:
> > >
> > > Introduce support for Zoned Block Devices to virtio.
> > >
> > > Zoned Block Devices (ZBDs) aim to achieve a better capacity, latency
> > > and/or cost characteristics compared to commonly available block
> > > devices by getting the entire LBA space of the device divided to block
> > > regions that are much larger than the LBA size. These regions are
> > > called zones and they can only be written sequentially. More details
> > > about ZBDs can be found at
> > >
> > > https://zonedstorage.io/docs/introduction/zoned-storage .
> > >
> > > In its current form, the virtio protocol for block devices (virtio-bl=
k)
> > > is not aware of ZBDs but it allows the guest to successfully scan a
> > > host-managed drive provided by the host. As the result, the
> > > host-managed drive appears at the guest as a regular drive that will
> > > operate erroneously under the most common write workloads.
> > >
> > > To fix this, the virtio-blk protocol needs to be extended to add the
> > > capabilities to convey the zone characteristics of host ZBDs to the
> > > guest and to provide the support for ZBD-specific commands - Report
> > > Zones, four zone operations and (optionally) Zone Append. The proposed
> > > standard extension aims to provide this functionality.
> > >
> > > This patch extends the virtio-blk section of virtio specification with
> > > the minimum set of requirements that are necessary to support ZBDs.
> > > The resulting device model is a subset of the models defined in ZAC/Z=
BC
> > > and ZNS standards documents. The included functionality mirrors
> > > the existing Linux kernel block layer ZBD support and should be
> > > sufficient to handle the host-managed and host-aware HDDs that are on
> > > the market today as well as ZNS SSDs that are entering the market at
> > > the moment of this patch submission.
> > >
> > > I have developed a proof of concept patch series that adds ZBD support
> > > to virtio-blk Linux kernel driver by implementing the protocol
> > > extensions defined in the spec patch. I would like to receive the
> > > initial feedback on this specification patch before posting that seri=
es
> > > to the block LKML.
> > >
> > > I would like to thank the following people for their useful feedback
> > > and suggestions while working on the initial iterations of this patch.
> > >
> > > Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > > Matias Bj=F8rling <Matias.Bjorling@wdc.com>
> > > Niklas Cassel <Niklas.Cassel@wdc.com>
> > > Hans Holmberg <Hans.Holmberg@wdc.com>
> > >
> > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > ---
> > >  content.tex | 686 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 685 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index 7508dd1..8ae7578 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -4557,6 +4557,11 @@ \subsection{Feature bits}\label{sec:Device Typ=
es /
> > > Block Device / Feature bits}
> > >       maximum erase sectors count in \field{max_secure_erase_sectors}=
 and
> > >       maximum erase segment number in \field{max_secure_erase_seg}.
> > >
> > > +\item[VIRTIO_BLK_F_ZONED(17)] Device is a Zoned Block Device, that i=
s, a
> > > device
> > > +       that behaves as defined by the T10 Zoned Block Command standa=
rd (ZBC
> > > r05) or
> > > +       the NVMe(TM) NVM Express Zoned Namespace Command Set Specific=
ation
> > > 1.1b
> > > +       (ZNS).
> >
> > The rest of the spec doesn't mention ZBC/ZNS but at least the zone
> > state machine is likely to be derived from these standards. Have you
> > reviewed the license/IP terms of VIRTIO, ZBC, and ZNS to check that
> > it's okay to do this? It's probably okay but I wanted to mention it
> > because it would be a shame to discover an IP issue after the VIRTIO
> > spec has been released.
>
> I've read the virtio LICENSE.md file and visited the links that are inclu=
ded in
> this file.
>
> I am not a legal expert, but I don't expect any IP-related issues to aris=
e by
> including this patch. The T10 committee is an INCITS entity which is a pa=
rt of
> ANSI, a public standards body. This is the committee that develops SCSI s=
tandards
> that are already supported by the virtio spec and ZBC is simply another S=
CSI
> standard, alongside with SPC, SBC and so on. The member companies of T10 =
usually
> have a legal review process to make sure that all the standards that are =
being
> released are not encumbered by any patent claims, etc.
>
> ZNS is a product of NVM Express, an open standard consortium. Here is the=
 page on
> their site that has the link to ZNS command set specification pdf file -
>
> https://nvmexpress.org/developers/nvme-command-set-specifications/
>
> This consortium also has a legal review process and I don't foresee any I=
P-
> related difficulties that would arise from following this specification f=
or the
> purposes of making a virtio ZBD standard.
>
> >
> > Also, the wording suggests to me that the spec will refer to ZBC/ZNS
> > instead of defining the behavior itself, but actually you've written a
> > full self-contained spec (which is great!). Maybe change "behaves as
> > defined by" to "follows the zoned storage device model that is also
> > supported by industry standards such as".
>
> Agreed, the wording here could be more precise. This could be "follows th=
e zoned
> storage device behavior that is also supported by industry standards such=
 as". I
> would avoid using the word "model" here because it usually refers specifi=
cally to
> host-managed vs. host-aware vs. drive-managed device models in ZBD world.
>
> >
> >
> > > +
> > >  \end{description}
> > >
> > >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Type=
s /
> > > Block Device / Feature bits / Legacy Interface: Feature bits}
> > > @@ -4589,6 +4594,31 @@ \subsection{Device configuration
> > > layout}\label{sec:Device Types / Block Device /
> > >  \field{max_secure_erase_sectors} \field{secure_erase_sector_alignmen=
t} are
> > > expressed
> > >  in 512-byte units if the VIRTIO_BLK_F_SECURE_ERASE feature bit is
> > > negotiated.
> > >
> > > +If the VIRTIO_BLK_F_ZONED feature is negotiated, then in
> > > +\field{virtio_blk_zoned_characteristics},
> > > +\begin{itemize}
> > > +\item \field{zone_sectors} value is expressed in 512-byte sectors.
> > > +\item \field{max_append_sectors} value is expressed in 512-byte sect=
ors.
> > > +\item \field{write_granularity} value is expressed in bytes.
> > > +\end{itemize}
> > > +
> > > +The \field{model} field in \field{zoned} may have the following valu=
es:
> > > +VIRTIO_BLK_Z_HM(1) and VIRTIO_BLK_Z_HA(2).
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_BLK_Z_HM        1
> > > +#define VIRTIO_BLK_Z_HA        2
> > > +\end{lstlisting}
> > > +
> > > +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> > > +\begin{itemize}
> > > +\item The value of VIRTIO_BLK_Z_HM MUST be set by the device if it o=
perates
> > > +    as a host-managed zoned block device.
> >
> > The term host-managed is not defined. Please either define it or
> > include a reference to the zoned storage device model (maybe
> > zonedstorage.io?).
>
> OK, indeed. There is some text later in the patch describing the differen=
ces
> between Sequential Write Required (SWR) and Sequential Write Preferred (S=
WP)
> zones, but the wording that relates HM to SWR and HA to SWP is missing, w=
ill add
> it here.
>
> >
> > > +
> > > +\item The value of VIRTIO_BLK_Z_HA MUST be set by the device if it o=
perates
> > > +    as a host-aware zoned block device.
> >
> > The term host-aware is not defined.
> >
> > > +\end{itemize}
> >
> > The VIRTIO spec is organized into normative sections containing
> > MUST/MAY/SHOULD and descriptive sections. MUST/MAY/SHOULD need to go
> > in drivernormative or devicenormative sections and can't be used in
> > descriptive sections.
> > (I believe the reason for this is to give driver/device implementors a
> > definitive list of normative statements they can easily review without
> > re-reading the entire text of the specification.)
>
>
> Got it, will reword.
>
> > +
> >  \begin{lstlisting}
> >  struct virtio_blk_config {
> >          le64 capacity;
> > @@ -4623,6 +4653,15 @@ \subsection{Device configuration
> layout}\label{sec:Device Types / Block Device /
> >          le32 max_secure_erase_sectors;
> >          le32 max_secure_erase_seg;
> >          le32 secure_erase_sector_alignment;
> > +        struct virtio_blk_zoned_characteristics {
> > +                le32 zone_sectors;
> > +                le32 max_open_zones;
> > +                le32 max_active_zones;
> > +                le32 max_append_sectors;
> > +                le32 write_granularity;
> > +                u8 model;
> > +                u8 unused2[3];
> > +        } zoned;
> >  };
> >  \end{lstlisting}
> >
> > @@ -4686,6 +4725,10 @@ \subsection{Device Initialization}\label{sec:Dev=
ice
> Types / Block Device / Devic
> >      \field{secure_erase_sector_alignment} can be used by OS when split=
ting a
> >      request based on alignment.
> >
> > +\item If the VIRTIO_BLK_F_ZONED feature is negotiated, the fields in
> > +    \field{zoned} can be read by the driver to determine the zone
> > +    characteristics of the device. All \field{zoned} fields are read-o=
nly.
> > +
> >  \end{enumerate}
> >
> >  \drivernormative{\subsubsection}{Device Initialization}{Device Types /=
 Block
> Device / Device Initialization}
> > @@ -4701,6 +4744,24 @@ \subsection{Device Initialization}\label{sec:Dev=
ice
> Types / Block Device / Devic
> >  The driver MUST NOT read \field{writeback} before setting
> >  the FEATURES_OK \field{device status} bit.
> >
> > +Drivers SHOULD NOT negotiate VIRTIO_BLK_F_ZONED feature if they are in=
capable
> > +of supporting devices with the VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA zone=
d model.
>
> > This raises the question whether devices can offer VIRTIO_BLK_F_ZONED
> > but fall back to regular block device operation if the driver does not
> > negotiate the bit?
>
> It could be useful (for testing/development, etc.) to allow the device to=
 offer
> the VIRTIO_BLK_F_ZONED feature even when the actual backing block device =
is not
> zoned. In this case, it the driver is capable of handling ZBDs, it will a=
ccept it
> and the i/o should be operational via virtio_blk_zoned_req requests with
> VIRTIO_BLK_Z_NONE model. Therefore there is a SHOULD NOT. Perhaps it is w=
orth it
> to add this explanation to the text... or not to allow this at all and ch=
ange the
> text to "must not".
>
> Regarding fallbacks, there are clauses below that define these situations=
 and
> they mostly boil down to the following -
> 1. if the device offers VIRTIO_BLK_F_ZONED with an HM backing device and =
the
> driver doesn't negotiate the feature, the device needs to disallow the de=
vice to
> operate by not setting FEATURES_OK bit.
> 2. if the device offers VIRTIO_BLK_F_ZONED with an *HA* backing device an=
d the
> driver doesn't negotiate the feature, the device needs to present the dev=
ice as
> non-zoned because in this case it will still work.
>
> > +
> > +If the VIRTIO_BLK_F_ZONED feature is offered by the device, the
> > +VIRTIO_BLK_F_DISCARD feature MUST NOT be offered.
> >
> > This statement partially precludes that because it requires devices to
> > disable VIRTIO_BLK_F_DISCARD if they advertize VIRTIO_BLK_F_ZONED. I
> > think there is a way to allow VIRTIO_BLK_F_DISCARD in
> > !VIRTIO_BLK_F_ZONED mode while forbidding it in VIRTIO_BLK_F_ZONED
> > mode: the device can fail to set FEATURES_OK when the driver writes
> > the Device Status field with VIRTIO_BLK_F_DISCARD &&
> > VIRTIO_BLK_F_ZONED. That way a host-aware device in
> > !VIRTIO_BLK_F_ZONED mode could allow VIRTIO_BLK_F_DISCARD. Is this
> > useful?
>
> Good catch, I verified that HA devices can usually handle discard. In thi=
s case,
> the clause above becomes too strict. Perhaps it should be changed to
>
> If the VIRTIO_BLK_F_ZONED feature is offered by the device with the
> VIRTIO_BLK_Z_HM zone model, then
>  - the VIRTIO_BLK_F_DISCARD feature must not be offered by the driver.
>  - if the driver sets both VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_ZONED fe=
ature
> bits, the device must fail by not setting FEATURES_OK bit.

Sounds good.


>
> >
> > > +
> > > +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> > > +\begin{itemize}
> > > +\item If the driver that can not support host-managed zoned devices
> > > +    reads VIRTIO_BLK_Z_HM from the \field{model} field of \field{zon=
ed}, the
> > > +    driver MUST NOT set FEATURES_OK flag and instead set the FAILED =
bit.
> > > +
> > > +\item If the driver that can not support support zoned devices reads
> > > +    VIRTIO_BLK_Z_HA from the \field{model} field of \field{zoned}, t=
he
> > > driver
> > > +    MAY present the device to the guest as a non-zoned device. In th=
is case,
> > > the
> >
> > Please avoid using the terms "guest" or "host" in the virtualization
> > sense and instead use "driver" and "device". VIRTIO can be used in
> > non-virtualization use cases and it's clearer to avoid virtualization
> > terminology.
>
> OK, will change this.
>
> >
> > > +    driver SHOULD ignore all other fields in \field{zoned}.
> >
> > Why would the driver negotiate VIRTIO_BLK_F_ZONED if it doesn't
> > support zoned devices?
>
> This covers cases when the driver can recognize the VIRTIO_BLK_F_ZONED fe=
ature,
> but it is incapable to support ZBDs for some reason. For example, the Lin=
ux
> virtio-blk driver could be up to date with ZBD support, but if the kernel=
 is
> built without CONFIG_BLK_DEV_ZONED option, it will not be able to handle =
HM
> devices. But it still can deal with HA drives in this case.

I see, thanks.


>
> >
> > > +\end{itemize}
> > > +
> > >  \devicenormative{\subsubsection}{Device Initialization}{Device Types=
 / Block
> > > Device / Device Initialization}
> > >
> > >  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> > > @@ -4712,6 +4773,77 @@ \subsection{Device Initialization}\label{sec:D=
evice
> > > Types / Block Device / Devic
> > >  The device MUST initialize padding bytes \field{unused0} and
> > >  \field{unused1} to 0.
> > >
> > > +If the device that is being initialized is a not a zoned device, the=
 device
> > > MUST
> > > +NOT offer the VIRTIO_BLK_F_ZONED feature.
> > > +
> > > +If the VIRTIO_BLK_F_ZONED bit is not set by the driver,
> > > +\begin{itemize}
> > > +\item the device with the VIRTIO_BLK_Z_HA zone model SHOULD proceed =
with the
> > > +    initialization while setting all zoned topology fields to zero.
> > > +
> > > +\item the device with the VIRTIO_BLK_Z_HM zone model MUST report the=
 device
> > > +    capacity in \field{capacity} in the configuration space as zero =
to
> > > prevent
> > > +    the use of the device that is incorrectly recognized by the driv=
er as
> > > +    a non-zoned device.
> >
> > I suggest changing this to "MUST fail to set the FEATURES_OK device
> > status bit when the driver writes the Device Status field". That way
> > the driver gets a clear error instead of seeing a virtio-blk device
> > with 0 capacity.
>
> OK. I was under impression that only the driver can do this. It's certain=
ly
> better to fail the initialization in this case.
>
> >
> >
> > > +\end{itemize}
> > > +
> > > +If the VIRTIO_BLK_F_ZONED feature is negotiated,
> > > +\begin{itemize}
> > > +\item \field{zoned} can be read by the driver to discover the size o=
f a
> > > single
> > > +    zone on the device. All zones of the device have the same size i=
ndicated
> > > by
> > > +    the \field{zone_sectors} field of \field{zoned} except for the l=
ast zone
> > > +    that MAY be smaller than all other zones. The driver can calcula=
te the
> > > +    number of zones on the device as
> > > +    \begin{lstlisting}
> > > +        nr_zones =3D (capacity + zone_sectors - 1) / zone_sectors;
> > > +    \end{lstlisting}
> > > +    and the size of the last zone as
> > > +    \begin{lstlisting}
> > > +        zs_last =3D capacity - (nr_zones - 1) * zone_sectors;
> > > +    \end{lstlisting}
> > > +
> > > +\item Zones consume volatile device resources while being in certain=
 states
> > > and
> > > +    the device MAY set limits on the number of zones that can be in =
these
> > > states
> > > +    simultaneously.
> > > +
> > > +    Zoned block devices use two internal counters to account for the=
 device
> > > +    resources in use, the number of currently open zones and the num=
ber of
> > > +    currently active zones.
> > > +
> > > +    Any zone state transition from a state that doesn't consume a zo=
ne
> > > resource
> > > +    to a state that consumes the same resource increments the intern=
al
> > > device
> > > +    counter for that resource. Any zone transition out of a state th=
at
> > > consumes
> > > +    a zone resource to a state that doesn't consume the same resource
> > > decrements
> > > +    the counter. Any request that causes the device to exceed the re=
ported
> > > zone
> > > +    resource limits is terminated by the device with an error.
> >
> > "an error" is vague. I was wondering what the exact error should be.
> > Please either mention the error codes here or add "as defined for
> > specific commands later" so it's clear that the device doesn't get the
> > choose the error code but they are defined by the spec.
>
> Right. The error is defined later in the text, it's worth mentioning it h=
ere.
>
> >
> > > +
> > > +\item The \field{max_open_zones} field of the \field{zoned} structur=
e can be
> > > +    read by the driver to discover the maximum number of zones that =
can be
> > > open
> > > +    on the device (zones in the implicit open or explicit open state=
). A
> > > value
> > > +    of zero indicates that the device does not have any limit on the=
 number
> > > of
> > > +    open zones.
> > > +
> > > +\item The \field{max_active_zones} field of the \field{zoned} struct=
ure can
> > > be
> > > +    read by the driver to discover the maximum number zones that can=
 be
> > > active
> > > +    on the device (zones in the implicit open, explicit open or clos=
ed
> > > state).
> > > +    A value of zero indicates that the device does not have any limi=
t on the
> > > +    number of active zones.
> > > +
> > > +\item the \field{max_append_sectors} field of \field{zoned} can be r=
ead by
> > > the
> > > +    driver to get the maximum data size of a VIRTIO_BLK_T_ZONE_APPEND
> > > request
> > > +    issued to the device. The value of this field MUST NOT exceed the
> > > +    \field{seg_max} * \field{size_max} value. A device MAY set the
> > > +    \field{max_append_sectors} to zero if it doesn't support
> > > +    VIRTIO_BLK_T_ZONE_APPEND requests.
> >
> > The MUST NOT/MAY statements need to be in a drivernormative section.
> > There are more instances below.
>
> Yea, I need to sort this out everywhere in the patch.
>
> >
> >
> > > +
> > > +\item the \field{write_granularity} field of \field{zoned} can be re=
ad by
> > > the
> > > +    driver to discover the offset and size alignment constraint for
> > > +    VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_ZONE_APPEND requests issued to
> > > +    a sequential zone of the device.
> > > +
> > > +\item the device MUST initialize padding bytes \field{unused2} to 0.
> > > +\end{itemize}
> > > +
> > >  \subsubsection{Legacy Interface: Device Initialization}\label{sec:De=
vice
> > > Types / Block Device / Device Initialization / Legacy Interface: Devi=
ce
> > > Initialization}
> > >
> > >  Because legacy devices do not have FEATURES_OK, transitional devices
> > > @@ -4738,7 +4870,8 @@ \subsubsection{Legacy Interface: Device
> > > Initialization}\label{sec:Device Types /
> > >  \subsection{Device Operation}\label{sec:Device Types / Block Device =
/ Device
> > > Operation}
> > >
> > >  The driver queues requests to the virtqueues, and they are used by
> > > -the device (not necessarily in order). Each request is of form:
> > > +the device (not necessarily in order). If the VIRTIO_BLK_F_ZONED fea=
ture
> > > +is not negotiated, then each request is of form:
> > >
> > >  \begin{lstlisting}
> > >  struct virtio_blk_req {
> > > @@ -4853,6 +4986,331 @@ \subsection{Device Operation}\label{sec:Devic=
e Types
> > > / Block Device / Device Ope
> > >  command produces VIRTIO_BLK_S_IOERR.  A segment may have completed
> > >  successfully, failed, or not been processed by the device.
> > >
> > > +The following requirements only apply if the VIRTIO_BLK_F_ZONED feat=
ure is
> > > +negotiated.
> > > +
> > > +Each request is of form:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_blk_zoned_req {
> > > +        le32 type;
> > > +        le32 reserved;
> > > +        le64 sector;
> > > +        union zoned_params {
> > > +                struct {
> > > +                        /* ALL zone operation flag */
> > > +                        __u8 all;
> > > +                        __u8 unused1[3];
> > > +                } mgmt_send;
> > > +                struct {
> > > +                        /* Partial zone report flag */
> > > +                        __u8 partial;
> > > +                        __u8 unused2[3];
> > > +                } mgmt_receive;
> > > +                struct {
> > > +                        __u8 unused3[4];
> > > +                } append;
> > > +        } zone;
> > > +        u8 data[];
> > > +        le64 zone_result;
> > > +        u8 status;
> > > +        u8 reserved1[3];
> >
> > Please make status the last byte so device implementations can reuse
> > their existing request completion code to handle virtio_blk_zoned_req.
> > Either reserved1[] can be removed or it can be moved before status.
>
> OK.
>
> >
> > Here is the non-union representation of the structs. Note that this
> > means existing request processing code can handle IN/OUT/FLUSH even
> > when VIRTIO_BLK_F_ZONED is negotiated. We don't need two different
> > code paths for these common commands:
> >
> > /* IN/OUT/FLUSH/DISCARD/WRITE_ZEROES */
> > struct virtio_blk_req {
> >         le32 type;
> >         le32 reserved;
> >         le64 sector;
> >         u8 data[];
> >         u8 status;
> > };
> >
> > /* ZONE_APPEND */
> > struct virtio_blk_req_zone_append {
> >         le32 type;
> >         le32 reserved;
> >         le64 sector;
> >         u8 data[];
> >         le64 zone_result;
> >         u8 status;
> > };
> >
> > /* ZONE_OPEN, ZONE_CLOSE, ZONE_FINISH, ZONE_RESET */
> > struct virtio_blk_req_zone_mgmt_send {
> >         le32 type;
> >         le32 reserved;
> >         le64 sector;
> >         /* ALL zone operation flag */
> >         __u8 all;
> >         __u8 unused1[3];
> >         u8 data[];
> >         u8 status;
> > };
> >
> > /* ZONE_REPORT */
> > struct virtio_blk_req_zone_mgmt_receive {
> >         le32 type;
> >         le32 reserved;
> >         le64 sector;
> >         /* Partial zone report flag */
> >         __u8 partial;
> >         __u8 unused2[3];
> >         u8 data[];
> >         u8 status;
> > };
>
> We felt that it is less confusing to have a single ZBD request structure =
so there
> is 1:1 relationship between the VIRTIO_BLK_F_ZONED bit value and the choi=
ce of
> the request -
>
> VIRTIO_BLK_F_ZONED off ->  virtio_blk_req
> VIRTIO_BLK_F_ZONED on ->  virtio_blk_zoned_req
>
> We also want to make sure that zone management/send/receive and append re=
quests
> are always the same size and it should be easier with a single request
> structure.
>
> It is possible to use a simpler, but less structured union here -
>
> struct virtio_blk_zoned_req {
>         le32 type;
>         le32 reserved;
>         le64 sector;
>         union zoned_params {
>                 /* ALL zone operation flag */
>                 __u8 all;
>                 /* Partial zone report flag */
>                 __u8 partial;
>                 __u32 rsvd1;
>         } zone;
>         u8 data[];
>         le64 zone_result;
>         u8 reserved1[3];
>         u8 status;
> }
>
> Using the single code path is very important and the PoC Linux driver cod=
e that I
> have sketched up achieves that. Since the request header is identical for=
 the
> both cases, I hope that it can be done in QEMU too.

There are two possibilities for optimizing the request layout:
1. For drivers and devices that implement both !VIRTIO_BLK_F_ZONED and
VIRTIO_BLK_F_ZONED. Here it's best to share the same request layout
for commands available in both modes. In other words IN and OUT
requests to zoned devices should use struct virtio_blk_req so code can
be shared and only commands unique to zoned devices use struct
virtio_blk_zoned_req.
2. For drivers and devices that implement only one of
!VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_ZONED. Here consistent request
layout is best so the code parses all commands in the same way. In
other words, IN and OUT requests to zoned devices use struct
virtio_blk_zoned_req so that the implementation doesn't have to bother
with struct virtio_blk_req at all.

I think you chose #2 and I gravitated towards #1. Which one is optimal
depends on the use case. Feel free to stick with #2.


>
> >
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +In addition to the request types defined for non-zoned devices, the =
type of
> > > the
> > > +request can be a zone report (VIRTIO_BLK_T_ZONE_REPORT), an explicit=
 zone
> > > open
> > > +(VIRTIO_BLK_T_ZONE_OPEN), an explicit zone close (VIRTIO_BLK_T_ZONE_=
CLOSE),
> > > a
> > > +zone finish (VIRTIO_BLK_T_ZONE_FINISH), a zone_append
> > > (VIRTIO_BLK_T_ZONE_APPEND)
> > > +or a zone reset (VIRTIO_BLK_T_ZONE_RESET).
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_BLK_T_ZONE_APPEND    15
> > > +#define VIRTIO_BLK_T_ZONE_REPORT    16
> > > +#define VIRTIO_BLK_T_ZONE_OPEN      18
> > > +#define VIRTIO_BLK_T_ZONE_CLOSE     20
> > > +#define VIRTIO_BLK_T_ZONE_FINISH    22
> > > +#define VIRTIO_BLK_T_ZONE_RESET     24
> > > +\end{lstlisting}
> > > +
> > > +Requests of the type VIRTIO_BLK_T_ZONE_REPORT are reads and requests=
 of the
> > > type
> >
> > Here "reads" means data transfers from the device to the driver rather
> > than disk reads. I found that confusing. Maybe
> > "VIRTIO_BLK_T_ZONE_REPORT transfer data from the device"?
>
> Sure, your wording is better.
>
> > For a cur
> > > +VIRTIO_BLK_T_ZONE_APPEND are writes. VIRTIO_BLK_T_ZONE_OPEN,
> > > +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and
> > > VIRTIO_BLK_T_ZONE_RESET
> > > +are non-data requests.
> > > +
> > > +In ZBD standards, the VIRTIO_BLK_T_ZONE_REPORT request belongs to "Z=
one
> >
> > "ZBD standards" is not defined. I think this refers to the zoned
> > storage device model and its embodiment in the ZBC/ZNS specs.
>
> > The configuration space fields already allow the driver to calculate
> > the total number of zones. What is the purpose of partial=3D0, it
> > doesn't seem to provide any new information?
>
> Both ZBC and ZNS have this categorization. "ZBD standards" can be defined=
 earlier
> in the text as a catchall for ZBC/ZNS.

Great.

> If partial is 0, the nr_zones will contain the number of zones that poten=
tially
> can be reported starting from the request "sector" position and until the=
 end of
> sector range of the device. It does not necessarily equal the total numbe=
r of
> zones on the drive.

The driver knows zone_sectors and nr_zones, so it can calculate
nr_zones - (sector / zone_sectors) itself. Why send a ZONE_REPORT
partial=3D0 request to the device to get this value?


>
> >
> > When the device marks a virtqueue buffer used, it indicates the number
> > of bytes written (struct virtq_used_elem's len field). The driver can
> > use this field to determine the number of descriptors filled in by the
> > device. Is the nr_zones field really necessary?
>
> This field can help when the buffer is larger than the returned number of
> descriptors, but nr_zones is still needed for the partial=3D0 case above.
>
> >
> >
> > > +
> > > +A zone descriptor has the following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_blk_zone_descriptor {
> > > +        le64   z_cap;
> > > +        le64   z_start;
> > > +        le64   z_wp;
> > > +        u8     z_type;
> > > +        u8     z_state;
> > > +        u8     reserved[38];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The zone descriptor field \field{z_type} \field{virtio_blk_zone_desc=
riptor}
> > > +indicates the type of the zone. The available types are
> > > VIRTIO_BLK_ZT_CONV(1),
> > > +VIRTIO_BLK_ZT_SWR(2) or VIRTIO_BLK_ZT_SWP(3).
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_BLK_ZT_CONV     1
> > > +#define VIRTIO_BLK_ZT_SWR      2
> > > +#define VIRTIO_BLK_ZT_SWP      3
> > > +\end{lstlisting}
> > > +
> > > +Read and write operations into zones with the VIRTIO_BLK_ZT_CONV
> > > (Conventional)
> > > +type have the same behavior as read and write operations on a regula=
r block
> > > +device. Any block in a conventional zone can be read or written at a=
ny time
> > > and
> > > +in any order.
> > > +
> > > +Zones with VIRTIO_BLK_ZT_SWR (Sequential Write Required or SWR) can =
be read
> > > +randomly, but MUST be written sequentially at a certain point in the=
 zone
> > > called
> > > +the Write Pointer (WP). With every write, the Write Pointer is incre=
mented
> > > by
> > > +the number of sectors written.
> > > +
> > > +Zones with VIRTIO_BLK_ZT_SWP (Sequential Write Preferred or SWP) can=
 be read
> > > +randomly and SHOULD be written sequentially, similarly to SWR zones.
> > > However,
> > > +SWP zones can accept random write operations, that is, VIRTIO_BLK_T_=
OUT
> > > requests
> > > +with a start sector different from the zone write pointer position.
> > > +
> > > +The field \field{z_state} of \field{virtio_blk_zone_descriptor} indi=
cates
> > > the
> > > +state of the device zone. The available zone states are
> > > VIRTIO_BLK_ZS_NOT_WP(0),
> > > +VIRTIO_BLK_ZS_EMPTY(1), VIRTIO_BLK_ZS_IOPEN(2), VIRTIO_BLK_ZS_EOPEN(=
3),
> > > +VIRTIO_BLK_ZS_CLOSED(4), VIRTIO_BLK_ZS_RDONLY(13), VIRTIO_BLK_ZS_FUL=
L(14)
> > > and
> > > +VIRTIO_BLK_ZS_OFFLINE(15).
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_BLK_ZS_NOT_WP   0
> > > +#define VIRTIO_BLK_ZS_EMPTY    1
> > > +#define VIRTIO_BLK_ZS_IOPEN    2
> > > +#define VIRTIO_BLK_ZS_EOPEN    3
> > > +#define VIRTIO_BLK_ZS_CLOSED   4
> > > +#define VIRTIO_BLK_ZS_RDONLY   13
> > > +#define VIRTIO_BLK_ZS_FULL     14
> > > +#define VIRTIO_BLK_ZS_OFFLINE  15
> > > +\end{lstlisting}
> > > +
> > > +Zones of the type VIRTIO_BLK_ZT_CONV are always reported by the devi=
ce to be
> > > in
> > > +the VIRTIO_BLK_ZS_NOT_WP state. Zones of the types VIRTIO_BLK_ZT_SWR=
 and
> > > +VIRTIO_BLK_ZT_SWP can not transition to the VIRTIO_BLK_ZS_NOT_WP sta=
te.
> > > +
> > > +Zones in VIRTIO_BLK_ZS_EMPTY (Empty), VIRTIO_BLK_ZS_IOPEN (Implicitl=
y Open),
> > > +VIRTIO_BLK_ZS_EOPEN (Explicitly Open) and VIRTIO_BLK_ZS_CLOSED (Clos=
ed)
> > > state
> > > +are writable, but zones in VIRTIO_BLK_ZS_RDONLY (Read-Only),
> > > VIRTIO_BLK_ZS_FULL
> > > +(Full) and VIRTIO_BLK_ZS_OFFLINE (Offline) state are not. The write =
pointer
> > > +value (\field{z_wp}) is not valid for Read-Only, Full and Offline zo=
nes.
> > > +
> > > +The zone descriptor field \field{z_cap} contains the maximum number =
of 512-
> > > byte
> > > +sectors that are available to be written with user data when the zon=
e is in
> > > the
> > > +Empty state. This value shall be less than or equal to the
> > > \field{zone_sectors}
> > > +value in \field{virtio_blk_zoned_characteristics} structure in the d=
evice
> > > +configuration space.
> > > +
> > > +The zone descriptor field \field{z_start} contains the 64-bit addres=
s of the
> > > +first 512-byte sector of the zone.
> > > +
> > > +The zone descriptor field \field{z_wp} contains the 64-bit sector ad=
dress
> > > where
> > > +the next write operation for this zone should be issued. This value =
is
> > > undefined
> > > +for conventional zones and for zones in VIRTIO_BLK_ZS_RDONLY,
> > > VIRTIO_BLK_ZS_FULL
> > > +and VIRTIO_BLK_ZS_OFFLINE state.
> > > +
> > > +Depending on their state, zones consume resources as follows:
> > > +\begin{itemize}
> > > +\item a zone in VIRTIO_BLK_ZS_IOPEN and VIRTIO_BLK_ZS_EOPEN state co=
nsumes
> > > one
> > > +    open zone resource and, additionally,
> > > +
> > > +\item a zone in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN and
> > > +    VIRTIO_BLK_ZS_CLOSED state consumes one active resource.
> > > +\end{itemize}
> > > +
> > > +Attempts for zone transitions that violate zone resource limits MUST=
 fail
> > > with
> > > +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
> > > +\field{zone_result}.
> >
> > Why use zone_result instead of the status field? The _S_ naming
> > suggests this is a status field constant, not a zone_result constant.
>
> zone_result only a valid ZBD error if the status is VIRTIO_BLK_S_IOERR. I=
f the
> status is VIRTIO_BLK_S_OK, this field may contain ALBA for Zone Append re=
quest.
> It is possible to just define the ZBD-specific error codes following
> VIRTIO_BLK_S_UNSUPP, but I think it is cleaner to create a separate numbe=
ring for
> ZBD-specific codes and keep the non-zoned errors as-is in their impressive
> simplicity.
>
> The ZBD error codes all currently have _S_ZONE_ naming, but it might be b=
etter to
> use something like _ZR_ for example, i.e.
>
> #define VIRTIO_BLK_ZR_INVALID_CMD     0
> #define VIRTIO_BLK_ZR_UNALIGNED_WP    1
> #define VIRTIO_BLK_ZR_OPEN_RESOURCE   2
> #define VIRTIO_BLK_ZR_ACTIVE_RESOURCE 3

IMO multiple levels of result codes adds complexity in the driver
implementation, especially when zoned and non-zoned code is shared. It
can make error handling and reporting in drivers awkward (e.g. do
error messages for zoned devices include a separate zone_result field
while non-zoned devices just have the status field in their error
messages?). I would use status codes but if you really want to keep
the zoned error codes separate then _ZR_ naming is good.

--BApgZ1ROK/JCnqDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKZwYsACgkQnKSrs4Gr
c8i9sQf+NoASL747PUZvsF6Qw0nmKWBgSVCPnfnPN6BDHwJcIMFxa1qz/72YAq6b
ImBeMh7f8OFQbolipap7qhsflznHLpe3DjyA29QH7D93P9oSpuF9wHxSk8M93JUO
SO8WH+Spdfrct6u+/GAhN2XD5xzq3bi1EMlKkvuBI6CmTdikRbydYuEMVoQ8XTNn
zy8pi1SY1Ww2oPfdzpupF29eFARQ7LT8F1thp+6qy1KMOhUg7btpa5QXBguhlqnb
J1jfAspP8Iotmjwv5Jk4hgMjQxWfuxpI5OZJOMJlLWRMjSIbCYccj2DUE5SM5DGO
lYQCTrPHvC6pfMhz+9ELFMFhNc1ntw==
=Sq8F
-----END PGP SIGNATURE-----

--BApgZ1ROK/JCnqDv--

