Return-Path: virtio-dev-return-3280-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Mon, 26 Feb 2018 18:51:11 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180226105111.4rcxkimh6uapywhj@debian>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <20180224051706.fjemv3etmswgyqjz@debian>
 <20180225204425-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180225204425-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v8 08/16] packed virtqueues: more
 efficient virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Feb 25, 2018 at 08:49:10PM +0200, Michael S. Tsirkin wrote:
> On Sat, Feb 24, 2018 at 01:17:08PM +0800, Tiwei Bie wrote:
> > On Fri, Feb 16, 2018 at 09:24:12AM +0200, Michael S. Tsirkin wrote:
[...]
> > > +\subsection{Event Suppression Structure Format}\label{sec:Basic
> > > +Facilities of a Virtio Device / Packed Virtqueues / Event Suppression Structure
> > > +Format}
> > > +
> > > +The following structure is used to reduce the number of
> > > +notifications sent between driver and device.
> > > +
> > > +\begin{lstlisting}
> > > +__le16 desc_event_off : 15; /* Descriptor Event Offset */
> > > +int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> > 
> > Is this `int` a typo?
> 
> It's a single bit so I think it does not matter.
> What type would you like me to use instead?

It looks a bit strange to use different types here, and
that's why I asked. If there is no particular reason to
use `int` here, maybe it's better to keep using __le16.

Besides, just for fun. For C language, I checked gcc and
clang. It seems that `int desc_event_wrap:1;` is a signed
type. So, e.g. `p->desc_event_wrap == 1` is always false.

Best regards,
Tiwei Bie

> 
> > > +__le16 desc_event_flags : 2; /* Descriptor Event Flags */
> > > +\end{lstlisting}
[...]

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

