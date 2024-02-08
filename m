Return-Path: <virtio-dev-return-14296-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B336C48260
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Feb 2024 06:57:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9D3612B12F
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Feb 2024 06:57:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BD099868E1
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Feb 2024 06:57:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4134598622F; Thu,  8 Feb 2024 06:57:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E3B59868A0
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Feb 2024 06:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: V_qc0BF_MMeQjPk25w0VqQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Pape, Andreas (ADITG/ESS3)" <apape@de.adit-jv.com>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>
In-Reply-To: <10d461c112924dce8f29215359889b7b@de.adit-jv.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <10d461c112924dce8f29215359889b7b@de.adit-jv.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 08 Feb 2024 07:56:55 +0100
Message-ID: <8734u3igug.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] sound: add sampling rates 12000Hz and
 24000Hz

On Mon, Feb 05 2024, "Pape, Andreas (ADITG/ESS3)" <apape@de.adit-jv.com> wrote:

> 24kHz is used for 'super wideband' voice transmission 12kHz is added 'for completeness'
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/184
>
> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
> ---
>  device-types/sound/description.tex | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/device-types/sound/description.tex b/device-types/sound/description.tex
> index 54c9c8e..bad4415 100644
> --- a/device-types/sound/description.tex
> +++ b/device-types/sound/description.tex
> @@ -504,7 +504,9 @@ \subsubsection{PCM Control Messages}\label{sec:Device Types / Sound Device / Dev
>      VIRTIO_SND_PCM_RATE_96000,
>      VIRTIO_SND_PCM_RATE_176400,
>      VIRTIO_SND_PCM_RATE_192000,
> -    VIRTIO_SND_PCM_RATE_384000
> +    VIRTIO_SND_PCM_RATE_384000,
> +    VIRTIO_SND_PCM_RATE_12000,
> +    VIRTIO_SND_PCM_RATE_24000
>  };
>  
>  struct virtio_snd_pcm_info {

I think there had been a Reviewed-by: for a previous iteration of this
patch? We can add it while applying (after voting, which I'm going to
initiate); but I'd appreciate it if the previous reviewer could reply
here again.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

