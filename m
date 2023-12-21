Return-Path: <virtio-dev-return-14194-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F1C46CCD
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 09:54:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 917822A89C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 09:54:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 891E798660D
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 09:54:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B1319865BA; Thu, 21 Dec 2023 09:54:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D0FB9865C1
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2023 09:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: UC7Xox29NAGxL9Yue0_Lng-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
 broonie@kernel.org, qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
In-Reply-To: <86d97639-eb01-4db7-88ec-0adccb45abec@quicinc.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
 <87wmtbg4ad.fsf@redhat.com>
 <e076f6b7-595e-4910-96c9-96366faadfe8@quicinc.com>
 <87cyv0eyhy.fsf@redhat.com>
 <86d97639-eb01-4db7-88ec-0adccb45abec@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 21 Dec 2023 10:54:31 +0100
Message-ID: <87a5q3g9t4.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

On Thu, Dec 21 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

> Hi Cornelia,
>
> On 12/21/2023 4:44 PM, Cornelia Huck wrote:
>> On Thu, Dec 21 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>>>> Please move inclusion of this new file into content.tex here, instead of
>>>> including a not-yet-existing file in the previous patch.
>>>>
>>>> (...)
>>>
>>>
>>> Sorry, I don't quite understand here. Maybe I should not add the
>>> following line in content.tex, is that so?
>>>
>>> \input{device-types/spi/description.tex}
>> 
>> No, please add this line; but do so in this patch instead of the
>> previous one that only changes the wording.
>
> I am not clear where to put this line? In the commit message or in the 
> main text, e.g. at the start of the description.tex? As follows:
>
> diff --git a/device-types/spi/description.tex 
> b/device-types/spi/description.tex
> new file mode 100644
> index 0000000..b76258c
> --- /dev/null
> +++ b/device-types/spi/description.tex
> @@ -0,0 +1,281 @@
> +\input{device-types/spi/description.tex}
> +\section{SPI Controller Device}\label{sec:Device Types / SPI Controller 
> Device}
> +
> ...

Ah no, the inclusion is of course in the right place where you put it in
context.tex; the *patch hunk* should be moved from patch 1 to patch 2,
that's all. Hope that's more clear now :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

