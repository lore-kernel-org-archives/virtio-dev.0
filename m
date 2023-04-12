Return-Path: <virtio-dev-return-12196-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DC0C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 08:47:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E0D02AEE0
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 08:47:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E97B986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 08:47:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE020986512; Wed, 12 Apr 2023 08:47:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC55098651C
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 08:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: C3brKBLnNHCNlAtt8hQTnA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230411192554.751994-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230411192554.751994-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 12 Apr 2023 10:47:09 +0200
Message-ID: <87wn2hjxma.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] introduction: Add missing helping verb

On Tue, Apr 11 2023, Parav Pandit <parav@nvidia.com> wrote:

> The terminology of Transitional device and driver is missing the helping
> verb 'is' similar to other terminologies.
>
> Hence, add them to complete the sentence.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  introduction.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/introduction.tex b/introduction.tex
> index 287c5fc..e8b34e3 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -145,14 +145,14 @@ \subsection{Legacy Interface: Terminology}\label{intro:Legacy
>  
>  \begin{description}
>  \item[Transitional Device]
> -        a device supporting both drivers conforming to this
> +        is a device supporting both drivers conforming to this
>          specification, and allowing legacy drivers.
>  \end{description}
>  
>  Similarly, a driver MAY implement:
>  \begin{description}
>  \item[Transitional Driver]
> -        a driver supporting both devices conforming to this
> +        is a driver supporting both devices conforming to this
>          specification, and legacy devices.
>  \end{description}

I'd rather not add the "is" (and drop the trailing ".", as this is not
supposed to be a sentence), as this would read awkwardly. I think it is
intended to be:

<xyz> MAY implement:

<list of things>

which does not really ask for a sentence.

Same thing applies to the section right above, where it talks about
legacy support; I'd drop the "is" there instead.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

