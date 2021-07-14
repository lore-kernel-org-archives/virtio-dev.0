Return-Path: <virtio-dev-return-8276-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 296DA9863DB
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Jul 2021 07:15:41 +0000 (UTC)
Date: Wed, 14 Jul 2021 03:15:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210714031300-mutt-send-email-mst@kernel.org>
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
 <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
Subject: Re: [virtio-dev] review of virtio-can (was: Re: MSG_CONFIRM RX
 messages with SocketCAN known as unreliable under heavy load?)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <hmo@opensynergy.com>, linux-can@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 25, 2021 at 11:19:38AM +0200, Marc Kleine-Budde wrote:
> On 24.06.2021 17:21:15, Harald Mommer wrote:
> > First draft went to virtio-comment@lists.oasis-open.org and
> > virtio-dev@lists.oasis-open.org.
> > 
> > https://markmail.org/search/?q=virtio-can&q=list%3Aorg.oasis-open.lists.virtio-comment#query:virtio-can%20list%3Aorg.oasis-open.lists.virtio-comment+page:1+mid:hdxj35fsthypllkt+state:results
> 
> > [virtio-dev] [PATCH 1/1] [RFC] virtio-can: Add the device specification.
> > Harald Mommer Thu, 01 Apr 2021 08:21:09 -0700
> > 
> > virtio-can is a virtual CAN device. It provides a way to give access to
> > a CAN controller from a driver guest. The device is aimed to be used by
> > driver guests running a HLOS as well as by driver guests running a
> > typical RTOS as used in controller environments.
> 
> Let's open the focus of this driver and not limit us to RTOSes.
> 
> > ---
> >  content.tex      |   1 +
> >  introduction.tex |   3 +
> >  virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 virtio-can.tex
> > 
> > diff --git a/content.tex b/content.tex
> > index e536fd4..c1604db 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing 
> > Requirements}\label{sec:Device
> >  \input{virtio-mem.tex}
> >  \input{virtio-i2c.tex}
> >  \input{virtio-scmi.tex}
> > +\input{virtio-can.tex}
> >  
> >  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >  
> > diff --git a/introduction.tex b/introduction.tex
> > index 7204b24..84ea5c0 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative References}
> >         \phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
> >         Arm System Control and Management Interface, DEN0056,
> >         \newline\url{https://developer.arm.com/docs/den0056/c}, version C and 
> > any future revisions\\
> > +       \phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
> > +       Specification of CAN Driver -- AUTOSAR CP R20-11,
> 
> As mentioned before don't make this AUTOSAR specific.

If the specs are more or less identical it might be worth it to link
to AUTOSAR too just because it can be downloaded for free.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

