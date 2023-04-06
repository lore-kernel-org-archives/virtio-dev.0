Return-Path: <virtio-dev-return-12037-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACC8C76196
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:17:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D8F6823D53
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:17:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA8D99865CA
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:17:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BC2BE9865B7; Thu,  6 Apr 2023 07:17:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A709B9865B8;
	Thu,  6 Apr 2023 07:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="331276972"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="331276972"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="830652132"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="830652132"
Message-ID: <921ea18c-044d-bf53-fd2d-0f762335d640@intel.com>
Date: Thu, 6 Apr 2023 15:15:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <984303d7cd2413b00873a3cea803c2fa17108e83.1680533760.git.mst@redhat.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <984303d7cd2413b00873a3cea803c2fa17108e83.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v11 01/10] virtio: document forward compatibility
 guarantees



On 4/3/2023 11:03 PM, Michael S. Tsirkin wrote:
> Feature negotiation forms the basis of forward compatibility
> guarantees of virtio but has never been properly documented.
> Do it now.
>
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>
> Changes in v11:
> 	make explanation about not using any unspecified bits
> 	more detailed as suggested by Cornelia and David
> ---
>   content.tex | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 0e474dd..8098988 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -114,21 +114,65 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>   In particular, new fields in the device configuration space are
>   indicated by offering a new feature bit.
>   
> +To keep the feature negotiation mechanism extensible, it is
> +important that devices \em{do not} offer any feature bits that
> +they would not be able to handle if the driver accepted them
> +(even though drivers are not supposed to accept any unspecified,
> +reserved, or unsupported features even if offered, according to
> +the specification.) Likewise, it is important that drivers \em{do
> +not} accept feature bits they do not know how to handle (even
> +though devices are not supposed to offer any unspecified,
> +reserved, or unsupported features in the first place,
> +according to the specification.) The preferred
> +way for handling reserved and unexpected features is that the
> +driver ignores them.
> +
> +In particular, this is
> +especially important for features limited to specific transports,
> +as enabling these for more transports in future versions of the
> +specification is highly likely to require changing the behaviour
> +from drivers and devices.  Drivers and devices supporting
> +multiple transports need to carefully maintain per-transport
> +lists of allowed features.
> +
>   \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>   The driver MUST NOT accept a feature which the device did not offer,
>   and MUST NOT accept a feature which requires another feature which was
>   not accepted.
>   
> +The driver MUST validate the feature bits offered by the device.
> +The driver MUST ignore and MUST NOT accept any feature bit that is
> +\begin{itemize}
> +\item not described in this specification,
> +\item marked as reserved,
> +\item not supported for the specific transport,
> +\item not defined for the device type.
> +\end{itemize}
> +
>   The driver SHOULD go into backwards compatibility mode
>   if the device does not offer a feature it understands, otherwise MUST
>   set the FAILED \field{device status} bit and cease initialization.
>   
> +By contrast, the driver MUST NOT fail solely because a feature
> +it does not understand has been offered by the device.
> +
>   \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>   The device MUST NOT offer a feature which requires another feature
>   which was not offered.  The device SHOULD accept any valid subset
>   of features the driver accepts, otherwise it MUST fail to set the
>   FEATURES_OK \field{device status} bit when the driver writes it.
>   
> +The device MUST NOT offer feature bits corresponding to features
> +it would not support if accepted by the driver (even if the
> +driver is prohibited from accepting the feature bits by the
> +specification); for the sake of clarity, this refers to feature
> +bits not described in this specification, reserved feature bits
> +and feature bits reserved or not supported for the specific
> +transport or the specific device type, but this does not preclude
> +devices written to a future version of this specification from
> +offering such feature bits should such a specification have a
> +provision for devices to support the corresponding features.
> +
>   If a device has successfully negotiated a set of features
>   at least once (by accepting the FEATURES_OK \field{device
>   status} bit during device initialization), then it SHOULD
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

