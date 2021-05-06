Return-Path: virtio-comment-return-1853-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 6 May 2021 10:43:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YJO6PgtOaJ86KF51@stefanha-x1.localdomain>
References: <20210401152013.17980-1-harald.mommer@opensynergy.com>
 <YIaQUdRjndmrBK2l@stefanha-x1.localdomain>
 <df232473-f2b9-9ef4-42d8-f172ecfddc96@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <df232473-f2b9-9ef4-42d8-f172ecfddc96@opensynergy.com>
Subject: Re: [virtio-comment] [PATCH 1/1] [RFC] virtio-can: Add the device
 specification.
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RLE3Y9pJfCZ+gAhd"
Content-Disposition: inline
To: Harald Mommer <hmo@opensynergy.com>
Cc: Harald Mommer <harald.mommer@opensynergy.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--RLE3Y9pJfCZ+gAhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2021 at 12:33:19PM +0200, Harald Mommer wrote:
> Am 26.04.21 um 12:05 schrieb Stefan Hajnoczi:
> > On Thu, Apr 01, 2021 at 05:20:13PM +0200, Harald Mommer wrote:
> > > diff --git a/introduction.tex b/introduction.tex
> > > index 7204b24..84ea5c0 100644
> > > --- a/introduction.tex
> > > +++ b/introduction.tex
> > > @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative =
References}
> > >   =09\phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
> > >   =09Arm System Control and Management Interface, DEN0056,
> > >   =09\newline\url{https://developer.arm.com/docs/den0056/c}, version =
C and any future revisions\\
> > > +=09\phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
> > > +=09Specification of CAN Driver -- AUTOSAR CP R20-11,
> > > +=09\newline\url{https://www.autosar.org/fileadmin/user_upload/standa=
rds/classic/20-11/AUTOSAR_SWS_CANDriver.pdf}\\
> > "The commercial exploitation of the material contained in this work
> > requires a license to such intellectual property rights."?
> >=20
> > CAN is an ISO standard. What is the relationship to AUTOSAR and why not
> > reference the ISO standard? The CAN Wikipedia page
> > (https://en.wikipedia.org/wiki/CAN_bus) only mentions ISO, not AUTOSAR.
>=20
> The AUTOSAR CAN driver specification describes an API for an AUTOSAR CAN
> driver. One of the goals was that it should be possible to write a virtio
> CAN driver providing a usable subset of the AUTOSAR CAN driver API. There
> are collegues here working on embeeded controllers using AUTOSAR and virt=
io
> CAN should serve their purposes. On the other hand, virtio CAN must also
> serve the needs for the non-AUTOSAR audience. In the end the specificatio=
n
> must fulfill the needs of the AUTOSAR audience and the non-AUTOSAR audien=
ce
> dancing on two weddings at the same time.
>=20
> Not referenced the ISO standard because I did not really look into this t=
o
> develop the specification. Referenced what I really looked in to specify
> something which MAY be used to develop a virtio CAN driver with an AUTOSA=
R
> CAN driver interface on top.
>=20
> If the special licensing of the AUTOSAR specification is a problem (guess=
 it
> is) I think the solution is to ensure that a non AUTOSAR implementation c=
an
> be done without having to look into the AUTOSAR specification itself. If
> this is not sufficient I need to know to address the problem properly.

Yes, that sounds good. The VIRTIO spec can reference ISO standards while
still being flexible enough for AUTOSAR. Although I'm not familiar with
CAN, what you specified so far seems like core functionality that is
probably also covered in other standards under more permissive licensing
terms.

>=20
> > Also, does the AUTOSAR reference mean that this is a specific flavor of
> > CAN that may not be compatible with other CAN variants?
>=20
> This reference to the AUTOSAR spec does not mean that virtio CAN is
> incompatible with ISO. It just means that I looked heavily into the AUTOS=
AR
> CAN specifiation.
>=20
> But it may be that my brain is polluted with too much AUTOSAR the draft
> specification does not fulfill all needs of audience not interested in
> AUTOSAR but for example in Linux SocketCAN. During last week working at s=
ome
> driver/device prototype using SocketCAN I realized that there is no suppo=
rt
> for remote transmission request frames in the virtio CAN draft specificat=
ion
> but in SocketCAN. AUTOSAR does not support this, the feature was removed
> totally from CAN FD. Could be that the missing support is a shortcoming.
> Could be that the feature was removed from CAN FD because nobody in the
> world is using it and it's obsolete.
>=20
> So some detail(s) which may be considered mandatory - also some I'm not e=
ven
> aware of - may be missing. I hope to get some feedback about this on the
> list.

Is there someone we can invite to review the spec from a CAN
perspective? Maybe someone you work with who is experienced with CAN.
Otherwise we could ask the Linux CAN maintainers for input (Wolfgang
Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>).

> > >   \end{longtable}
> > > diff --git a/virtio-can.tex b/virtio-can.tex
> > > new file mode 100644
> > > index 0000000..c343759
> > > --- /dev/null
> > > +++ b/virtio-can.tex
> > > @@ -0,0 +1,245 @@
> > > +\section{CAN Device}\label{sec:Device Types / CAN Device}
> > > +
> > > +virtio-can is a virtio based CAN (Controller Area Network) device. I=
t is
> > s/device/controller/ ?
> yes
> > > +used to give a virtual machine access to a CAN bus. The CAN bus may
> > > +either be a physical CAN bus or a virtual CAN bus between virtual
> > > +machines or a combination of both.
> > > +
> > > +This section relies on definitions made by the AUTOSAR
> > > +\hyperref[intro:CAN_Driver]{CAN Driver} specification.
> > > +
> > > +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device =
ID}
> > > +
> > > +36
> > > +
> > > +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqu=
eues}
> > > +
> > > +\begin{description}
> > > +\item[0] Txq
> > > +\item[1] Rxq
> > > +\item[2] Controlq
> > > +\item[3] Indicationq
> > > +\end{description}
> > > +
> > > +The \field{Txq} is used to send CAN packets to the CAN bus.
> > > +
> > > +The \field{Rxq} is used to receive CAN packets from the CAN bus.
> > > +
> > > +The \field{Controlq} is used to control the state of the CAN control=
ler.
> > > +
> > > +The \field{Indicationq} is used to receive unsolicited indications o=
f
> > > +CAN controller state changes.
> > > +
> > > +\subsection{Feature Bits}\label{sec:Device Types / CAN Device / Feat=
ure Bits}
> > > +
> > > +The virtio-can device always supports classic CAN frames with a maxi=
mum
> > > +payload size of 8 bytes.
> > > +
> > > +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.=
0B)
> > > +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> > > +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> > > +specification.
> > Please state this in a devicenormative section:
> >=20
> >    \devicenormative{\subsection}{...}
> >    The device MUST support CAN~2.0B Extended CAN IDs.
> >=20
> > The general spec text is informative and then specific statements about
> > what MUST, MUST NOT, SHOULD, etc are made in drivernormative and
> > devicenormative sections. You can find examples of this in the specs fo=
r
> > other devices.
> Means the document structure has to be reworked generally to have the
> requirements (MUST, SHOULD) in appropriate sections.

Yes, please.

> > > +
> > > +\end{description}
> > > +
> > > +\subsection{Device configuration layout}\label{sec:Device Types / CA=
N Device / Device configuration layout}
> > > +
> > > +All fields of this configuration are always available and read-only =
for
> > > +the driver.
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_can_config {
> > > +        le16 lo_prio_count;
> > > +        le16 hi_prio_count;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +To operate the Virtio CAN device it may be necessary to know some ba=
sic
> > > +properties of the underlying physical CAN controller hardware and it=
s
> > > +configuration.
> > > +
> > > +Physical CAN controllers may support transmission by putting message=
s
> > "may", "should", "can", "must", etc are not used in the informative
> > sections of the spec. Those kinds of statements go in the
> > drivernormative and devicenormative sections.
> Will have to restructure the document structure.
> > > +into FIFOs first and / or by using transmit buffers directly. The us=
er
> > > +of the Virtio CAN driver may need to know
> > This can be rewritten without the concept of a "physical CAN
> > controller". Simply describe lo_prio_count/hi_prio_count as properties
> > of the virtio-can device itself and then the physical CAN controller
> > concept isn't needed. This is makes the spec more general since emulate=
d
> > CAN controllers might have their own constraints even though there is n=
o
> > physical CAN controller.
>=20
> A classic CAN bus has a bandwith of typically 500 kbps. Which is not this
> much and is therefore to be considered as bottleneck. Virtual stuff come
> typically with bandwithes in the magnitude of the internal RAM (Gigabytes=
/s)
> or at least PCI (Gigabits/s). Prioritization makes no sense any more for
> those non-physical CAN devices on which the transport medium is magnitute=
s
> faster as a physical CAN bus. Have had this disussions internally any my
> opinion is that for non-physical devices prioritization makes no sense at
> all. So no, I prefer not to reformulate in this way.

If I understand correctly you are saying that
lo_prio_count/hi_prio_count will be determined by the physical CAN
controller since it is the bottleneck. Therefore it makes sense to
explicitly refer to the physical CAN controller here.

What lo_prio_count/hi_prio_count values should pure software
implementations of virtio-can use?

> > > +
> > > +\begin{itemize}
> > > +\item Number of TX FIFO places for non time critical CAN messages
> > > +\item Number of TX buffers for high priority CAN messages
> > Inconsistencies:
> > - FIFO places =3D=3D buffers?
> > - non time critical =3D=3D low priority?
> >=20
> > Please use terminology consistently. Don't introduce multiple terms for
> > the same thing.
> The different terminology is intentional as those are different things.
> There are wait queue places in the FIFO not participating in bus arbitrat=
ion
> and transmission buffers participating in bus arbitration.

This still isn't clear to me, probably because I don't know CAN. I'm not
sure what "TX FIFO" vs "TX buffers", "non time critical" vs "high
priority", or "wait queue places" are.

If this is obvious to someone who knows CAN then it's okay, but if you
can see a way to clarify things without explaining all of CAN from
scratch, then it would be nice to adjust this section.

> > > +\end{itemize}
> > > +
> > > +to schedule an optimal transmission of CAN messages. Non time critic=
al
> > > +messages may be sent via a FIFO where they may suffer "Inner Priorit=
y
> > > +Inversion" (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 2.1). Hi=
gh
> > > +priority messages are preferably sent directly to a transmit buffer
> > > +where they immediately participate in CAN bus arbitration.
> > Please mention lo_prio_count and hi_prio_count so their meaning is
> > unambiguous and they can easily be searched by name in the document. Th=
e
> > \begin{itemize} above should explicitly mention lo_prio_count and
> > hi_prio_count.
> If I understand this correctly it's a formatting issue which has to be
> addressed.

Yes, the text currently doesn't mention lo_prio_count/hi_prio_count
explicitly so the reader has to guess which parts of the text are
referring to which field. This could lead to confusion.

> > > +
> > > +\subsection{Device Initialization}\label{sec:Device Types / CAN Devi=
ce / Device Initialization}
> > > +
> > > +\begin{enumerate}
> > > +
> > > +\item Read the feature bits and negotiate with the device.
> > > +
> > > +\item Fill the virtqueue \field{Rxq} with empty buffers to be ready =
for
> > > +the reception of CAN messages.
> > How large do the buffers need to be? A drivernormative "MUST" statement
> > is probably needed for this.
> I consider this as an implementation decision. Doing an implementation l
> would provide enough buffers so that no CAN message received on the bus i=
s
> lost. The actual choice depends on the maximum received message rate, tim=
e
> to service a received CAN message and in case of a polling driver also on
> the polling cycle.

I meant how large does a single Rxq buffer need to be, in bytes, so that
the driver can successfully receive a CAN message? If the driver's Rxq
buffer size is too small the the contents of the buffer would not fit.
For example, classic Layer 2 Ethernet frames are 1522 bytes so a common
network driver rx buffer size is at least 1522 bytes.

> > > +
> > > +\item Fill the virtqueue \field{Indicationq} with empty buffers so t=
hat
> > > +the CAN device is able to provide status change indications to the
> > > +virtio CAN driver.
> > Do these buffers have a specific structure/size? I see struct
> > virtio_can_busoff_ind below but maybe a more general type is needed. If
> > the indication message types depend on the virtio-can device then it
> > could expose a configuration field so the driver knows how large
> > Indicationq buffers need to be.
>=20
> There is currently only one message type defined for this channel, this i=
s
> VIRTIO_CAN_BUSOFF_IND. The message definition (struct virtio_can_busoff_i=
nd)
> has a length of 2 bytes bearing only le16 msg_type. So a buffer with this=
 a
> size of 2 bytes has to be provided in order to bear the structure / messa=
ge.
> A future version of the specification may of course define an additional
> message type on the channel with a bigger structure / message definition =
but
> this would then require a feature flag to allow the device to send this
> indication. (Do I have understood the problem? There seems to be none.)

Yes, this is fine. Please state in the specification that Indicationq
buffers must be at least as large as struct virtio_can_busoff_ind so
that driver authors don't have to infer this.

> Will have to plan now internally when to update the draft spec and to
> re-send an updated version. I'm currently with both hands in some prototy=
pe
> implementation serving and using Linux SocketCAN. Prioritiziung this work
> may be benefitial for the next draft spec. as I may still learn about som=
e
> details and pitfalls doing an actual implementation.

Great. Most of my feedback was about specification writing and requests
for clarifications rather than issues with the virtio-can device design,
so once you have time to do the spec rewording I think there won't be
much more from my side. Overall this looks good.

Thanks,
Stefan

--RLE3Y9pJfCZ+gAhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCTuj4ACgkQnKSrs4Gr
c8if8wgAyTqrF9hNULc9sxZIzs7PxKJZ+isZ8tFEgrZBU1WhRfRn3iRQjlf9j5KS
KxUJY8ae6rT92xT4KUA0KrpuL3Fjetpq0TLNMVGhnriHbSLHdMFhm3gLRJTRGnQr
gY0BSxODy5PffXFReoHZHNDAOzcTQYY4HEjwn3PVfvQbnKqkAEx7eLsB+XegvSzw
2Fj9KRYO6vDCki+sIO5gw8uD7jR6rVyLINSLY5jS8g2CTg9zITUF8a5QIQcEixlv
Pwc5hQIUPn8mXzOZWhohcnQt2ozdiedEPOqRYRZF9F/iC0kv40MFAvn+BxJ5GyZO
INADIlECMJtFnYC6btDj3z9OwSfloA==
=c7KU
-----END PGP SIGNATURE-----

--RLE3Y9pJfCZ+gAhd--

