Return-Path: <mst@redhat.com>
Date: Thu, 2 Jun 2022 02:59:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
Message-ID: <20220602024254-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org>
 <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com>
 <87o7zvezkc.fsf@redhat.com>
 <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
 <CACGkMEsLRf+6PR8s0Vo2cv4ScMLBECtY+zDC2TSuov5NtPJVHQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsLRf+6PR8s0Vo2cv4ScMLBECtY+zDC2TSuov5NtPJVHQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 02, 2022 at 10:21:23AM +0800, Jason Wang wrote:
> On Wed, Jun 1, 2022 at 9:44 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >
> >
> > On 5/18/2022 4:32 PM, Cornelia Huck wrote:
> > > On Wed, May 18 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> > >
> > >> Hi MST,
> > >>
> > >> On 5/15/2022 6:25 PM, Michael S. Tsirkin wrote:
> > >>> On Wed, Apr 27, 2022 at 01:58:18AM +0300, Max Gurtovoy wrote:
> > >>>> +\subsection{Device group}\label{sec:Introduction / Terminology / Device group}
> > >>>> +
> > >>>> +A device group includes one or more virtio devices.
> > >>>> +Each virtio device has a unique virtio device id (vdev_id) within a device group. A valid vdev_id is a 64-bit field in the range of
> > >>>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a device group and isn't a valid vdev_id.
> > >>>> +
> > >>>> +For now, the supported device groups are:
> > >>>> +\begin{enumerate}
> > >>>> +\item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
> > >>>> +and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
> > >>>> +\end{enumerate}
> > >>>> +
> > >>>>    \section{Structure Specifications}\label{sec:Structure Specifications}
> > >>> In context of virtualization type 1 already refers to a specific type
> > >>> of hypervisor.
> > >>>
> > >>> I suggest simply "SR-IOV type" - this way users do not need to remember
> > >>> special terminology.
> > >> This is 12 lines addition commit with simple definition.
> > >>
> > >> I didn't mentioned hypervisors here.
> > >>
> > >> I will stick to your suggestion and use name instead of numbers
> > >> (although I don't understand how can a use that knows how to read spec
> > >> will be confused here), but I would like Jason and Cornelia to ack on
> > >> this during this review cycle.
> > >>
> > >> When we'll get 3 acks on this name - I'll update it for v6.
> > > So, do you want to imply some kind of numbering? I don't like "Type 1",
> > > either. If the type needs to be referenced in code, it should have a
> > > #define or such; otherwise, "SR-IOV type" would be fine.
> >
> > ok I'll change it to be:
> >
> > diff --git a/introduction.tex b/introduction.tex
> > index aa9ec1b..bba70a6 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -156,6 +156,18 @@ \subsection{Transition from earlier specification
> > drafts}\label{sec:Transition f
> >   sections tagged "Legacy Interface" in the section title.
> >   These highlight the changes made since the earlier drafts.
> >
> > +\subsection{Device group}\label{sec:Introduction / Terminology / Device
> > group}
> > +
> > +A device group includes one or more virtio devices.
> > +Each virtio device has a unique virtio device id (vdev_id) within a
> > device group. A valid vdev_id is a 64-bit field in the range of
> > +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that
> > refers to all devices in a device group and isn't a valid vdev_id.

BTW I don't really like inventing terms with underscores.
Let's stick to english if we can. By the way "id" is not a word, either
;) We have a couple of instances which we really should fix.
And "virtio device id" is confusingly similar to
virtio "device id" where device id is a term from pci.
And abbreviations really should be capitalized or end with a comma
but really best just avoided.

How about group member identifier? So

Each virtio device within a group has a unique member identifier.



> > +
> > +For now, the supported device groups are:
> > +\begin{enumerate}
> > +\item SR-IOV type - A virtio PCI SR-IOV physical function (PF) and its
> > PCI SR-IOV virtual functions (VFs). For this group type, the PF device
> > has vdev_id that is equal to 0
> > +and the VF devices have vdev_id's that are equal to their vf_number
> > (according to the PCI SR-IOV specification).

A bit better just from grammar perspective:

 \item SR-IOV type - the group includes a virtio PCI SR-IOV physical function (PF) and
 all its virtual functions (VFs). For this group type, the PF device
 has vdev_id of 0;
 each VF has a vdev_id matching it's VF number [link to SRIOV spec].

but note ideas on terminology above.

> > +\end{enumerate}
> > +
> >   \section{Structure Specifications}\label{sec:Structure Specifications}
> >
> > MST/Jason/Cornelia,
> >
> > can you add some Reviewed-By signatures if the above is agreed ?
> 
> If I understand this correctly, the idea of "device group" is to allow
> different groups to be managed by a single admin virtqueue?
> 
> And I feel that mixing transport specific definitions in the general
> admin virtqueue might not be optimal. So I wonder whether it's better
> to just say this is a transport specific type. And define it in the
> PCI transport part.
> 
> Thanks

Well it's a single paragraph here, I think it's ok for now for completeness
sake rather than have reader chase references just to figure out an
example.

But I do agree this sentence about SRIOV type has to be repeated
in the pci transport section for completeness of that one.



> >
> >
> >
> > >
> > >
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > >
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > >
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > >
> >

