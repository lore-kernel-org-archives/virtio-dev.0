Return-Path: <virtio-dev-return-13727-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E38BEE3F29
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 21:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A105CEEA11
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 21:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 609DD986630
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 21:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 470E4986084; Tue, 12 Sep 2023 21:05:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CE1B9866DE
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2023 21:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: S6aB49UHMy6snWZSi236mA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552732; x=1695157532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgtsTxMvDi5YQAJLFM+qh2D9eJ8Dnn4xRdA5kE9bFNc=;
        b=gD77O3zsc/Rsh3IOYSl99wpmmTi6wOt9AkoM1qQNmHtoaoAT9/LVZYjvdygblDou1j
         MONm7JTJ8NkeVFnFuCAFz0I54jIEqH8G5sBME7rStO4stfw5rxYACwroH+nTSiJw7Mpy
         Lj2cKFX4rILF1iAD2bSCg7QZhhmGwjlduHx9KCxAcvgj5pTb7JQRH/8VHtlhrdcHc6JG
         FBxuE+9pCraxnvs39CVb87AKTT7c9rO3V6Iulgc3l4qwWLjjVJ3dkVtCGpOfVCEnNmUO
         Ky4Z5WKR8bf8/00e1pwt+0auzZvptrNAcPMfXDDiC/88WrHAS0pzrqyI5q9+dZNugxSX
         CAuA==
X-Gm-Message-State: AOJu0Yz03Hkrpp4jbU/sDrVnzoc9ckhCrvZjBvdU5XHidYycrSyehO8k
	YX6RqlwqPdZBQsD/1g6dbPNOBb3qjYBk26l6slIa8XIVi3tVYvqzzNpvtKGfEyjZNdQNMlYSV5M
	sxDsLBgXzVcmfqqCEbdAkqVPaqMuc
X-Received: by 2002:a17:906:518a:b0:9a5:c9a4:ba1b with SMTP id y10-20020a170906518a00b009a5c9a4ba1bmr368391ejk.8.1694552731987;
        Tue, 12 Sep 2023 14:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfp4HB9N67rskCCETFeyfpFjUGPGYeiAi1Q/Bf8NrREusE2y1zhNykaRuglvC/dH8fzmN7kg==
X-Received: by 2002:a17:906:518a:b0:9a5:c9a4:ba1b with SMTP id y10-20020a170906518a00b009a5c9a4ba1bmr368375ejk.8.1694552731657;
        Tue, 12 Sep 2023 14:05:31 -0700 (PDT)
Date: Tue, 12 Sep 2023 17:05:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, aams@amazon.de
Message-ID: <20230912170032-mutt-send-email-mst@kernel.org>
References: <20221121162756.350032-1-mst@redhat.com>
 <20221121162756.350032-4-mst@redhat.com>
 <0abb7518-16e0-4227-bfe1-a29bd27124e8@amazon.es>
MIME-Version: 1.0
In-Reply-To: <0abb7518-16e0-4227-bfe1-a29bd27124e8@amazon.es>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

On Thu, Aug 31, 2023 at 12:16:22PM +0200, Babis Chalios wrote:
> Hi Michael,
> 
> On 21/11/22 17:30, Michael S. Tsirkin wrote:
> > Add virtqueues to support reporting entropy leaks (similar to virtio based vmgenid).
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   virtio-rng.tex | 61 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 60 insertions(+), 1 deletion(-)
> > 
> > diff --git a/virtio-rng.tex b/virtio-rng.tex
> > index 1ec7164..4760dfa 100644
> > --- a/virtio-rng.tex
> > +++ b/virtio-rng.tex
> > @@ -9,10 +9,14 @@ \subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID}
> >   \subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueues}
> >   \begin{description}
> >   \item[0] requestq
> > +\item[1] leakq1 (only if VIRTIO_RNG_F_LEAK is offered)
> > +\item[2] leakq2 (only if VIRTIO_RNG_F_LEAK is offered)
> >   \end{description}
> >   \subsection{Feature bits}\label{sec:Device Types / Entropy Device / Feature bits}
> > -  None currently defined
> > +\begin{description}
> > +\item[VIRTIO_RNG_F_LEAK (0)] Device can report and handle information leaks.
> > +\end{description}
> >   \subsection{Device configuration layout}\label{sec:Device Types / Entropy Device / Device configuration layout}
> >     None currently defined.
> > @@ -21,6 +25,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Entropy Device / Dev
> >   \begin{enumerate}
> >   \item The \field{requestq} virtqueue is initialized
> > +\item If VIRTIO_RNG_F_LEAK has been negotiated, \field{leakq1} and \field{leakq2} are initialized
> >   \end{enumerate}
> >   \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device Operation}
> > @@ -41,3 +46,57 @@ \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device O
> >   The device MUST place one or more random bytes into the buffer
> >   made available to it through \field{requestq}, but it
> >   MAY use less than the entire buffer length.
> > +
> > +\subsubsection{Reporting Information Leaks}{Device Types / Entropy Device / Device Operation / Reporting Information Leaks}
> > +
> > +The device might, after the fact, detect that some of the entropy
> > +it supplied to the driver has after the fact degraded in quality
> > +or leaked to the outside world.  One example is when the device
> > +is part of the virtual machine undergoing a restore from snapshot
> > +operation. Another example is when the information leaks from the
> > +host system through a side-channel.
> > +
> > +The driver would typically react by causing regeneration of any
> > +information that might have leaked and that has to be secret or
> > +unique.  It is understood that when an information leak has been
> > +detected it is likely not limited to the entropy received through
> > +the specific device. In particular, this is the case for
> > +snapshoting It is thus suggested that the system fully
> > +regenerate any unique/secret information in this scenario.
> > +
> > +If VIRTIO_RNG_F_LEAK has been negotiated the device can report
> > +such leaks to the driver through a set of dedicated leak
> > +queues: \field{leakq1} and \field{leakq2}.
> > +
> > +Buffers added to the leak queues can have one of two forms:
> > +\begin{enumerate}
> > +\item A write-only buffer. It will be completely filled by random data by the device.
> > +\item A buffer consisting of read-only section followed by a
> > +write-only section, both of identical size. The
> > +device will copy data from the read-only section to the write-only
> > +section.
> > +\end{enumerate}
> > +
> > +The steps for operating the virtqueue are:
> > +
> > +\begin{enumerate}
> > +\item At each time, only one of \field{leakq1}, \field{leakq2} is active
> > +      (has buffers added/used).
> > +\item After initialization, \field{leakq1} is active.
> > +\item Driver adds multiple buffers to the active leak queue.
> > +\item The buffers are not used until an information leak is
> > +      detected, as long as that is the case driver can
> > +      add more buffers to the active queue.
> > +\item Upon detecting an information leak, device starts
> > +      using buffers in the active leak queue.
> > +\item Upon detecting that buffers have been used, driver
> > +      switches to another leak queue making it active
> > +      (e.g. from \field{leakq1} to \field{leakq2} or vice versa).
> > +      It then starts adding buffers to the new leak queue.\
> 
> I have been discussing with Alex and we think there's a potential race here,
> between the time the driver
> sees the used buffers in the active leak queue until the time it adds new
> buffers to the next leak queue.
> If a new entropy leak event arrives the VMM won't find any buffers in the
> queue.

I do not understand why this matters though. we know there was a leak,
why does it matter whether there was one or two leaks?

> In the last RFC implementing this in Linux we sent to LKML [1] we avoid the
> issue by pre-populating both
> queues, but that does not solve the problem if a third entropy leak event
> arrives. The probability of this
> happening is indeed small, but we thought of a potential solution to this.
> 
> What if we modify the spec here to instruct the VMM to deny taking a
> snapshot if there are not any buffers
> in the active leak queue? If we did this, we could even simplify the spec to
> just introduce a single entropy
> leak queue, so we could avoid the complexity of switching between active
> leak queues in the driver and
> the device. WDYT?

here's the problem: 

- driver adds batch 1 of buffers
- leak
- device starts using buffers from batch 1
- driver sees some buffers and starts adding batch 2
- device sees batch 2 and thinks this is part of batch 1
  consumes them all




> Cheers,
> Babis
> 
> [1]
> https://lore.kernel.org/lkml/20230823090107.65749-3-bchalios@amazon.es/T/
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

