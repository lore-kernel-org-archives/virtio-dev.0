Return-Path: <virtio-dev-return-12011-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABFC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:57:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 22CDD41A15
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:57:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 133999865BA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:57:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 063AA983DE1; Wed,  5 Apr 2023 09:57:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAE7E9865A8
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 09:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: uuYQ1pfoMw2jseAKK13dQA-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, sgarzare@redhat.com,
 pasic@linux.ibm.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com
In-Reply-To: <20230405012723-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 05 Apr 2023 11:57:36 +0200
Message-ID: <87jzyqr6r3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v12 03/10] content: Rename confusing queue_notify_data
 and vqn names

On Wed, Apr 05 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 05, 2023 at 04:06:50AM +0300, Parav Pandit wrote:
>> diff --git a/content.tex b/content.tex
>> index cd93db2..d5f8026 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -405,8 +405,18 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>>  notification to the device.
>>  
>>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>> -this notification involves sending the
>> -virtqueue index to the device (method depending on the transport).
>> +this notification involves sending only the 16-bit virtqueue notification
>> +identifier (notification method depends on the transport).
>> +
>> +\begin{itemize}
>> +\item When VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated, virtqueue
>> +notification identifier is a 16-bit vq index.
>> +
>> +\item When VIRTIO_F_NOTIF_CONFIG_DATA is negotiated, virtqueue
>> +notification identifier is a device supplied virtqueue identifier. A method
>> +to supply such virtqueue notification identifier is transport
>> +specific.
>> +\end{itemize}
>>  
>>  However, some devices benefit from the ability to find out the
>>  amount of available data in the queue without accessing the virtqueue in memory:
>
>
> VIRTIO_F_NOTIF_CONFIG_DATA is such a narrow usecase, I don't like
> burning "vq identifier" on this. How about we just say something
> along the lines of:
>
>
> When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, this
> notification involves sending either the virtqueue index or the
> virtqueue config data to the device (method depending on the
> transport).
>
> And then "the data sent is a device supplied virtqueue config data".

Agreed, referring to "virtqueue configuration data" or somesuch is
better than using up the "vq identifier" name for it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

