Return-Path: <virtio-dev-return-13982-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E64CE7B09
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 07:54:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 58A5079573
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 07:54:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4873A9866B5
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 07:54:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C5A99864C6; Thu, 28 Sep 2023 07:54:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24237986397
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Sep 2023 07:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kg9VIwUWPv2GWdZoyMP3mQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
In-Reply-To: <f58da8a0fd3a40b24c9643499a2592d3ad38b73c.1695830118.git.mst@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <f58da8a0fd3a40b24c9643499a2592d3ad38b73c.1695830118.git.mst@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 28 Sep 2023 09:54:49 +0200
Message-ID: <87r0mivik6.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] [PATCH] html: add missing enumitem package

On Wed, Sep 27 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> makediffhtml.sh currently fails with:
>
> ! Missing number, treated as zero.
> <to be read again>
>                    \c@*
> l.25850 \begin{enumerate}[label=\alph*
>                                       .]
> ?
> ! Emergency stop.
> <to be read again>
>                    \c@*
> l.25850 \begin{enumerate}[label=\alph*
>                                       .]
>
> Some web searches turned up suggestions to use enumitem and in fact,
> virtio.tex already does this - but virtio-html.tex doesn't.
>
> Adding \usepackage{enumitem} in virtio-html.tex too fixes the issue.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  virtio-html.tex | 1 +
>  1 file changed, 1 insertion(+)
>

Oops, should read my mail before pushing. I'll use this one instead.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

