Return-Path: <virtio-dev-return-14313-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A10C48BEC
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 10:31:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4213C2355E
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 10:31:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35D189865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 10:31:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 29EC7986589; Wed, 14 Feb 2024 10:31:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CBB898658D
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 10:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7eVbi6YcN2icl2P9OgxJGw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, "Pape, Andreas
 (ADITG/ESS3)" <apape@de.adit-jv.com>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>
In-Reply-To: <719bcf1b-c9f8-41e9-9ee0-4f8b63148c2e@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <10d461c112924dce8f29215359889b7b@de.adit-jv.com>
 <719bcf1b-c9f8-41e9-9ee0-4f8b63148c2e@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 14 Feb 2024 11:31:24 +0100
Message-ID: <871q9fgww3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] sound: add sampling rates 12000Hz and
 24000Hz

On Wed, Feb 14 2024, Anton Yakovlev <anton.yakovlev@opensynergy.com> wrote:

> Thanks Pape!
>
>
> On 05.02.2024 23:41, Pape, Andreas (ADITG/ESS3) wrote:
>> 24kHz is used for 'super wideband' voice transmission 12kHz is added 'for completeness'
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/184
>> 
>> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
>
> Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Thanks for re-adding your R-b!

>
>> ---
>>   device-types/sound/description.tex | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

