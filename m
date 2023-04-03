Return-Path: <virtio-dev-return-11917-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2046C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:29:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29DE53DF2C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:29:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 223E8986420
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:29:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 170469863DE; Mon,  3 Apr 2023 17:29:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0347398640B
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 17:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ob1gXFs6MuOcA0Urzd6gYQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC/9g/MZl7CF2omMO4CTZFOQPp5ugJub6fo+y1vGFbo=;
        b=7AuwHmduBgVC8Rlz/Z6ypdj+UJPrxkK8Jo7zhVBjUWxIaaEX2VAnAE8aRJ7X41/er3
         XPrQE+AHK5+Q0IAo/mWuDV4+nEhZhtOODwOvnm48I0DFAhPA0N84xWhECddvZ3AUYjit
         TlMLazbx/hH8j1oap7i8P897IZsdG1UmJwgF5hAXK50pYFnv6Fn6VH70gXBCEfsiFXoO
         CdujqYK373E2pdgmmmwOO854CM50wjziSKzqOI8EPKj9MjKjFwzXIcc5f90egyXjp5Mv
         x13nFglNudF9hrOgvsApODMv3ytx3drPpKKv4L0+daImZ1lucH6YTVJjFwd+qKJ8ERN2
         1M3A==
X-Gm-Message-State: AAQBX9cF4jWc5ePg47mexb1j/5bmPKv5wRl8hDOLL3SU1O6yu9y3zuW/
	TaG5Wf8l2zPkRD33XZau81CP4nhgfkHqmhKMA7yvSf7OgYdSBH+U66kRWhaP0oSuhPKhgXca7vT
	/lscQxVlmJNZp6eY/zx0a5jAyxxnm
X-Received: by 2002:a17:906:9f26:b0:947:726e:f43a with SMTP id fy38-20020a1709069f2600b00947726ef43amr12761954ejc.23.1680542969731;
        Mon, 03 Apr 2023 10:29:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350YSqVy0dEmuuX5aogZzJWq0SAJD/Gc+aENghT+ophRDXu3nzgWdKiVxtkiYvd8TnhGnSUuaMA==
X-Received: by 2002:a17:906:9f26:b0:947:726e:f43a with SMTP id fy38-20020a1709069f2600b00947726ef43amr12761930ejc.23.1680542969451;
        Mon, 03 Apr 2023 10:29:29 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:29:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230403132907-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <71c1c5f86e19651585426160fc4cc15dc2da6ee6.1680533760.git.mst@redhat.com>
 <0fe1e488-a1e7-11a9-d2a2-3b8b7ee6a1c7@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0fe1e488-a1e7-11a9-d2a2-3b8b7ee6a1c7@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 07/10] ccw: document ADMIN_VQ as reserved

On Mon, Apr 03, 2023 at 11:55:29AM -0400, Parav Pandit wrote:
> 
> 
> On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> > Adding relevant registers needs more work and it's not
> > clear what the use-case will be as currently only
> > the PCI transport is supported. But let's keep the
> > door open on this.
> > We already say it's reserved in a central place, but it
> > does not hurt to remind implementers to mask it.
> > 
> s/implementers/implementation
> 
> > Note: there are more features to add to this list.
> > Will be done later with a patch on top.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   content.tex | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index f7446bf..1213d48 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2978,6 +2978,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
> >   MAY also choose to verify reset completion by reading \field{device status} via
> >   CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
> > +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
> > +
> > +At this time, devices and drivers utilizing Virtio over channel I/O
> > +do not support the following features:
> > +\begin{itemize}
> > +
> > +\item VIRTIO_F_ADMIN_VQ
> > +
> > +\end{itemize}
> > +
> > +These features are reserved for future use.
> > +
> >   \chapter{Device Types}\label{sec:Device Types}
> >   On top of the queues, config space and feature negotiation facilities
> 
> Same nit as that of mmio.

Sorry I don't get what this refers to.

> Reviewed-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

