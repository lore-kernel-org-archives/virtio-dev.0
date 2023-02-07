Return-Path: <virtio-comment-return-3986-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 7 Feb 2023 09:12:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230207090647-mutt-send-email-mst@kernel.org>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481B6E2510FB242B76BBB30DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B6E2510FB242B76BBB30DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 06, 2023 at 10:02:39PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Alvaro Karsz
> > ---
> > v2: Use SHOULD instead of Feature bit requirement, version 1.2 is already
> >     out and doesn't include this depencency.
> > 
> > v3: Explain the dependency in a less confusing way.
> > 
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > 
> >  device-types/net/description.tex | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index 700a1cb..1741c79 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -256,6 +256,9 @@ \subsection{Device configuration
> > layout}\label{sec:Device Types / Network Device  \field{duplex} fields as long as
> > VIRTIO_NET_S_LINK_UP is set in  the \field{status}.
> > 
> > +The device SHOULD NOT offer VIRTIO_NET_F_HASH_REPORT if it does not
> > +offer VIRTIO_NET_F_CTRL_VQ.
> > +
> I believe this applies to all the configurations done through the control VQ.
> So we should write a generic description instead of per feature statement like above.


I think we mostly have dependencies listed already. Dependencies
are a MUST though. It's a pity we forgot this one but oh well.
*Maybe* we want a section of a kind of "weak dependencies" for
cases like this where it's a SHOULD not a MUST.


> >  \drivernormative{\subsubsection}{Device configuration layout}{Device Types /
> > Network Device / Device configuration layout}
> > 
> >  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> > @@ -289,6 +292,9 @@ \subsection{Device configuration
> > layout}\label{sec:Device Types / Network Device  SHOULD re-read \field{speed}
> > and \field{duplex} after a  configuration change notification.
> > 
> > +A driver SHOULD NOT negotiate VIRTIO_NET_F_HASH_REPORT if it does not
> > +negotiate VIRTIO_NET_F_CTRL_VQ.
> > +
> Same for the driver too.
> Like below.
> The driver should not negotiate a feature that requires to use a control VQ when VIRTIO_NET_F_CTRL_VQ is not negotiated.
> Or driver must not .. ..
> Exception to that is VIRTIO_NET_F_HASH_REPORT, which driver should avoid negotiation ...

That's a vague enough not to be useful. VIRTIO_NET_F_HASH_REPORT
is not 100% through a queue, there's a list of supported hashes
that can be checked through config space.  Of limited usefulness
but still, e.g. you can know what's supported e.g. for management
purposes.



-- 
MST


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

