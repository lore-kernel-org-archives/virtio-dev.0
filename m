Return-Path: virtio-dev-return-4706-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A62AD985C22
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Jul 2018 11:11:28 +0000 (UTC)
Date: Mon, 16 Jul 2018 19:11:10 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180716111110.GB27375@debian>
References: <20180613092702.5544-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613092702.5544-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH v1] content: use a consistent wording for
 device status
To: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 13, 2018 at 05:27:02PM +0800, Tiwei Bie wrote:
> There is a part called "device status field" in a
> Virtio device. Currently, both of \field{status}
> and \field{device status} are used to refer to it,
> which is a bit confusing. This patch changes spec
> to use \field{device status} consistently.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/15
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Please start the voting for this proposal. Thanks!

Best regards,
Tiwei Bie

> ---
> v1:
> - Drop RFC from subject;
> - Add Fixes tag;
> 
>  content.tex | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index be18234..b8f7b0a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2099,7 +2099,7 @@ value.
>  
>  As described in
>  \ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits},
> -a device sometimes fails to set the \field{status} field: For example, it
> +a device sometimes fails to set the \field{device status} field: For example, it
>  might fail to accept the FEATURES_OK status bit during device initialization.
>  
>  With revision 2, CCW_CMD_READ_STATUS is defined: It reads an 8 bit status
> @@ -2109,10 +2109,11 @@ value from the device and acts as a reverse operation to CCW_CMD_WRITE_STATUS.
>  
>  If the device posts a unit check with command reject in response to the
>  CCW_CMD_WRITE_STATUS command, the driver MUST assume that the device failed
> -to set the status and the \field{status} field retained its previous value.
> +to set the status and the \field{device status} field retained
> +its previous value.
>  
>  If at least revision 2 has been negotiated, the driver SHOULD use the
> -CCW_CMD_READ_STATUS command to retrieve the \field{status} field after
> +CCW_CMD_READ_STATUS command to retrieve the \field{device status} field after
>  a configuration change has been detected.
>  
>  If not at least revision 2 has been negotiated, the driver MUST NOT attempt
> @@ -2120,12 +2121,14 @@ to issue the CCW_CMD_READ_STATUS command.
>  
>  \devicenormative{\paragraph}{Communicating Status Information}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
>  
> -If the device fails to set the \field{status} field to the value written by
> -the driver, the device MUST assure that the \field{status} field is left
> -unchanged and MUST post a unit check with command reject.
> +If the device fails to set the \field{device status} field
> +to the value written by the driver, the device MUST assure
> +that the \field{device status} field is left unchanged and
> +MUST post a unit check with command reject.
>  
>  If at least revision 2 has been negotiated, the device MUST return the
> -current \field{status} field if the CCW_CMD_READ_STATUS command is issued.
> +current \field{device status} field if the CCW_CMD_READ_STATUS
> +command is issued.
>  
>  \subsubsection{Handling Device Features}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
>  
> @@ -3665,7 +3668,7 @@ If VIRTIO_BLK_F_CONFIG_WCE was not negotiated but VIRTIO_BLK_F_FLUSH was,
>  the driver SHOULD assume presence of a writeback cache.
>  
>  The driver MUST NOT read \field{writeback} before setting
> -the FEATURES_OK \field{status} bit.
> +the FEATURES_OK \field{device status} bit.
>  
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>  
> @@ -3687,7 +3690,7 @@ legacy interface:
>  
>  \begin{itemize}
>  \item the driver MAY read or write \field{writeback} before setting
> -  the DRIVER or DRIVER_OK \field{status} bit
> +  the DRIVER or DRIVER_OK \field{device status} bit
>  
>  \item the device MUST NOT modify the cache mode (and \field{writeback})
>    as a result of a driver setting a status bit, unless
> -- 
> 2.17.0
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

