Return-Path: virtio-dev-return-6259-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B72F9983E7E
	for <virtio-dev@lists.oasis-open.org>; Sun, 27 Oct 2019 11:44:08 +0000 (UTC)
Date: Sun, 27 Oct 2019 07:44:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191027074247-mutt-send-email-mst@kernel.org>
References: <e0fb8838-c6c2-4c1e-4a14-d0b2671c524a@siemens.com>
 <20191014084502.GG22963@stefanha-x1.localdomain>
 <33e8a792-b27a-194e-ebe9-ed3795607c3e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e8a792-b27a-194e-ebe9-ed3795607c3e@siemens.com>
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Rename remaining
 QueueAvail/Used references
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 14, 2019 at 10:49:53AM +0200, Jan Kiszka wrote:
> On 14.10.19 10:45, Stefan Hajnoczi wrote:
> > On Sun, Oct 06, 2019 at 06:41:32PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> These have been changed in ae98c6bc21bc. Convert the rest.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  content.tex | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Please create a GitHub Issue so that a vote can be started:
> > https://github.com/oasis-tcs/virtio-spec/issues
> > 
> 
> Done: https://github.com/oasis-tcs/virtio-spec/issues/52
> 
> Jan

Ballot started. For the future, pls take a look at "Use of github
issues" in
https://github.com/oasis-tcs/virtio-spec/README.md

Thanks!

> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

