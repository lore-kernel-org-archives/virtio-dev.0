Return-Path: virtio-return-2923-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 27 Feb 2018 22:17:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227221208-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <20180224051706.fjemv3etmswgyqjz@debian>
 <20180225204425-mutt-send-email-mst@kernel.org>
 <20180226105111.4rcxkimh6uapywhj@debian>
 <20180226223702-mutt-send-email-mst@kernel.org>
 <20180227014928.ujlres3uuw6rb6vu@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227014928.ujlres3uuw6rb6vu@debian>
Subject: [virtio] Re: [virtio-dev] Re: [PATCH v8 08/16] packed virtqueues: more
 efficient virtqueue layout
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 09:49:28AM +0800, Tiwei Bie wrote:
> On Mon, Feb 26, 2018 at 10:38:13PM +0200, Michael S. Tsirkin wrote:
> > On Mon, Feb 26, 2018 at 06:51:11PM +0800, Tiwei Bie wrote:
> > > On Sun, Feb 25, 2018 at 08:49:10PM +0200, Michael S. Tsirkin wrote:
> > > > On Sat, Feb 24, 2018 at 01:17:08PM +0800, Tiwei Bie wrote:
> > > > > On Fri, Feb 16, 2018 at 09:24:12AM +0200, Michael S. Tsirkin wrote:
> > > [...]
> > > > > > +\subsection{Event Suppression Structure Format}\label{sec:Basic
> > > > > > +Facilities of a Virtio Device / Packed Virtqueues / Event Suppression Structure
> > > > > > +Format}
> > > > > > +
> > > > > > +The following structure is used to reduce the number of
> > > > > > +notifications sent between driver and device.
> > > > > > +
> > > > > > +\begin{lstlisting}
> > > > > > +__le16 desc_event_off : 15; /* Descriptor Event Offset */
> > > > > > +int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> > > > > 
> > > > > Is this `int` a typo?
> > > > 
> > > > It's a single bit so I think it does not matter.
> > > > What type would you like me to use instead?
> > > 
> > > It looks a bit strange to use different types here, and
> > > that's why I asked. If there is no particular reason to
> > > use `int` here, maybe it's better to keep using __le16.
> > > 
> > > Besides, just for fun. For C language, I checked gcc and
> > > clang. It seems that `int desc_event_wrap:1;` is a signed
> > > type. So, e.g. `p->desc_event_wrap == 1` is always false.
> > > 
> > > Best regards,
> > > Tiwei Bie
> > 
> > I'll switch to u8 here, IMHO le16 for a single bit
> > is really confusing. There's no byte order for a single byte.
> 
> Sorry, I just realized that I misunderstood your point
> previously.. Just to double check, `desc_event_off` and
> `desc_event_wrap` are not in the same 2 bytes?
> 
> Previously I thought both of them are in the first 2
> bytes. As it said it's a structure, and the fields are
> defined in a way very similar to the bit field in C.
> 
> In C,
> 
> struct {
> 	__le16 desc_event_off : 15;
> 	int    desc_event_wrap : 1;
> 	__le16 desc_event_flags : 2;
> };
> 
> struct {
> 	__le16 desc_event_off : 15;
> 	__le16 desc_event_wrap : 1;
> 	__le16 desc_event_flags : 2;
> };
> 
> struct {
> 	__le16 desc_event_off : 15,
> 	       desc_event_wrap : 1;
> 	__le16 desc_event_flags : 2;
> };
> 
> All above means `desc_event_off` and `desc_event_wrap`
> are in the first 2 bytes. So I thought the `int` is a
> typo. And I thought they are in the first 2 bytes (which
> is little-endian).
>
> Best regards,
> Tiwei Bie

Yes but desc_event_wrap itself is completely within the
second byte. So the question of byte-order does not arise.

Right, and above is also identical to:

 struct {
 	__le16 desc_event_off : 15,
 	u8     desc_event_wrap : 1;
 	__le16 desc_event_flags : 2;
 };

introduction explains:

\item[u8, u16, u32, u64] An unsigned integer of the specified length in bits.

\item[le16, le32, le64] An unsigned integer of the specified length in bits,
in little-endian byte order.



> > 
> > > > 
> > > > > > +__le16 desc_event_flags : 2; /* Descriptor Event Flags */
> > > > > > +\end{lstlisting}
> > > [...]

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

