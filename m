Return-Path: <virtio-dev-return-14162-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C8C35274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 11:05:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 609F02CAD9
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 11:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5115986445
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 11:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3F1DF986481; Mon, 18 Dec 2023 11:05:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CD8998647D
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2023 11:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mK6iThBRObyqO491agEBlg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
 broonie@kernel.org, qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com, Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231212033317.22198-3-quic_haixcui@quicinc.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 18 Dec 2023 12:04:42 +0100
Message-ID: <87wmtbg4ad.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

On Tue, Dec 12 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

[BTW: A changelog would be useful, either in the patch or in the cover
letter.]

> The Virtio SPI (Serial Peripheral Interface) device is a virtual
> SPI controller that allows the driver to operate and use the SPI
> controller under the control of the host.
>
> This patch adds the specification for virtio-spi.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  device-types/spi/description.tex        | 281 ++++++++++++++++++++++++
>  device-types/spi/device-conformance.tex |   7 +
>  device-types/spi/driver-conformance.tex |   7 +
>  3 files changed, 295 insertions(+)
>  create mode 100644 device-types/spi/description.tex
>  create mode 100644 device-types/spi/device-conformance.tex
>  create mode 100644 device-types/spi/driver-conformance.tex
>
> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex

Please move inclusion of this new file into content.tex here, instead of
including a not-yet-existing file in the previous patch.

(...)

> +\field{mode_func_supported} indicates whether the following features are supported or not:
> +        bit 0-1: CPHA feature,
> +            0b00: invalid, must support as least one CPHA setting.
> +            0b01: supports CPHA=0 only;
> +            0b10: supports CPHA=1 only;
> +            0b11: supports CPHA=0 and CPHA=1;
> +
> +        bit 2-3: CPOL feature,
> +            0b00: invalid, must support as least one CPOL setting.
> +            0b01: supports CPOL=0 only;
> +            0b10: supports CPOL=1 only;
> +            0b11: supports CPOL=0 and CPOL=1;
> +
> +        bit 4: chipselect active high feature, 0 for unsupported and 1 for supported,
> +            chipselect active low must always be supported.
> +
> +        bit 5: LSB first feature, 0 for unsupported and 1 for supported, MSB first must always be
> +            supported.
> +
> +        bit 6: loopback mode feature, 0 for unsupported and 1 for supported, normal mode
> +            must always be supported.
> +
> +Note: CPOL is clock polarity and CPHA is clock phase. If CPOL is 0, the clock idles at the logical
> +low voltage, otherwise it idles at the logical high voltage. CPHA determines how data is outputted
> +and sampled.

Shouldn't you also specify what CPHA==0 and CPHA==1 mean?


(...)

> +VIRTIO_SPI_TRANS_ERR indicates a transfer error, which means that the parameters are all
> +valid but the trasnfer process failed.

s/trasnfer/transfer/

LGTM otherwise. Does anybody else have comments?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

