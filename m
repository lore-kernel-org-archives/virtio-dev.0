Return-Path: <virtio-dev-return-12681-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA64C7EE22
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 09:43:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B98731CA250
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 09:43:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AED27986511
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 09:43:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3401986430; Mon, 15 May 2023 09:43:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90B5A98636A
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 09:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qzsR5QxHMq6_h1nWQzCGmA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org
Cc: sgarzare@redhat.com, pasic@linux.ibm.com, david.edmondson@oracle.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230505014614.571520-4-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230505014614.571520-1-parav@nvidia.com>
 <20230505014614.571520-4-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 15 May 2023 11:42:56 +0200
Message-ID: <87cz322an3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v17 03/11] content: Rename confusing queue_notify_data
 and vqn names

On Fri, May 05 2023, Parav Pandit <parav@nvidia.com> wrote:

> diff --git a/content.tex b/content.tex
> index 9cf938c..327926f 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -405,8 +405,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  notification to the device.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -this notification involves sending the
> -virtqueue index to the device (method depending on the transport).
> +this notification contains either a virtqueue index if
> +VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device supplied virtqueue
> +notification config data if VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> +
> +The notification method and suppling any such virtqueue notification config data
> +is transport specific.

Typo: s/suppling/supplying/ (trivial to fix on top)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

