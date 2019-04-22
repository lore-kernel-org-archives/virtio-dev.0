Return-Path: virtio-dev-return-5677-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB0AC984368
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Apr 2019 05:25:51 +0000 (UTC)
Date: Mon, 22 Apr 2019 01:25:49 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <591057556.22776395.1555910749793.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190419192118-mutt-send-email-mst@kernel.org>
References: <20190415062239.19717-1-pagupta@redhat.com> <20190419192118-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2] content: reserve device ID for virtio-pmem devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


> On Mon, Apr 15, 2019 at 11:52:39AM +0530, Pankaj Gupta wrote:
> > We need a device ID for virtio-pmem devices. As 25 is requested by
> > audio device and 26 is requested by virtio-fs, so requesting
> > next available(27). Also, updated the previously requested github
> > issue[1] for voting.
> > 
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/38
> 
> That's not the way to link it. You want:
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/38
> 
> Otherwise github will not recognize it.
> Also for guthub pls edit the main issue with new link to patch do not add new
> patch as
> a comment.

Sure. Submitted a new version v3 with suggested change.
Also, updated the github main issue with link to patch.

Thanks,
Pankaj
> 
> 
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> 
> > ---
> > v2:
> >  Use device ID 27
> >  
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index 193b6e1..aef7476 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2634,6 +2634,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline
> >  24         &   Memory device \\
> >  \hline
> > +27         &   PMEM device \\
> > +\hline
> >  \end{tabular}
> >  
> >  Some of the devices above are unspecified by this document,
> > --
> > 2.14.5
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

