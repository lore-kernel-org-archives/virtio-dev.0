Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281384279E9
	for <virtio-dev@lists.linux.dev>; Tue, 28 Jul 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243243; cv=none; b=kna3bf1Qpicb8SdB6IcQV0/U9Uxv553twofoUViWbyT7FwNes/XlmxkmWSfMm3jezn+mvhXddiENjD8+C2uXNy7mo4qlKarM9LuTEDxTiRqqnNQrQ9+9qwtCTVLU2401Z7T7KNV75xLjFAzhypqAvOG52Sk6KYJRiIkN8o8BWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243243; c=relaxed/simple;
	bh=YysH5jsrtcGezK7MNG+pQ8CCef1obHxI/WILbeJeICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5b1FJnUKrFf+StoCamye+X91F9uU13kD7bN/O9MZFai495ZfMBy6H54qAEbfhmpRBCPhDy78Jb770pZApVHww5PbUUxQozqJdPxixZseot9pYGFzniHF5Jec3/LBABMNvCGTzt7fxpjBTPjOC2Bd+Jqr+8R6ZU0XfTVKHH7ITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mXkXupkS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ByRznZuT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mXkXupkS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ByRznZuT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SCNkWS2518011
	for <virtio-dev@lists.linux.dev>; Tue, 28 Jul 2026 12:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=idUJR9vbh9mLeQ+LiDmPHED4
	Y3DRfFI4oiLrXFaY0Jo=; b=mXkXupkShT/yLK+Wus0to8i5zGa4VNZDUaLkT49i
	hprZ4t+eXVvkuXJDvEOqJOkAKM+yHsc3BjQnPyfAyQomwFn6O+wSot7MiKpgbNct
	vc1gLdHTG6JwECYYqENVZKy3eZnVTIq29LTHlwVQjOahJKL3j2ayj9Ksh3uySujS
	xeO2C46RcueOe78XgtLxazQ7Kw+Zm/NJmHtK1Dd5W5Tt+UIQgTEoQFd5mJ1A4+WW
	aI6zxCl2RH9C3aehQ2lM6DjArW/CCe95/iJbrivKkbX2CFjUMNQlrXW3mmLBIJL9
	78z9jBVCXh8Ai+lE05VzRah/flxMH0HsglAO6B9tv25Khw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpvd3g4ja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 28 Jul 2026 12:53:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c01ff996dso39397011cf.2
        for <virtio-dev@lists.linux.dev>; Tue, 28 Jul 2026 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785243233; x=1785848033; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=idUJR9vbh9mLeQ+LiDmPHED4Y3DRfFI4oiLrXFaY0Jo=;
        b=ByRznZuTsMb4ZwZMaSIR8zXDN52ZpDqbc/Qa8EVHmZWFIkwHGn9u0AUxeYG/WSDK8b
         nAuhV38AbEPxo58fHs8L7w9AGpawj1K2bJp7jhqBm+pR52xd6DqoCgD7W6SN6vEl9hMY
         NNksVqi4b3NVX62Ijj94mUl5mdaLu7TFqefNJDnho6kcf1O9LK8/8QGxmlWCEfgiN9a3
         mu3exSxndawTu5ZQYx7VcHzzbd8b7Jl0Ejg9caaxdytVo8VQLrloOYl0VayD8L3hm5/T
         R+CBKWZLeKpCMZmG3pB7pyElfa8ev4+7jjz0wCrgp6utctCG8HZLsnpgGfoGqiOVAUrn
         jiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243233; x=1785848033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idUJR9vbh9mLeQ+LiDmPHED4Y3DRfFI4oiLrXFaY0Jo=;
        b=DLAsRJsux9pG5Nurkq+gugywOUhqxARlkfbRg4M+T1MjNjIjnYXQdieap+So1HAa0o
         J5W/ArFBQ+34Mr9dilpurUF84lY3/oV65F8AcrxrdIsFgR+DyO8xivrpFs4ELXraFYzD
         euRhJAht4gWRW4pC4LZuhu+BCktdqWAitambtYJDyxi69D3G6gV4bSHOpSuDARPuG6s1
         YGl2XUNBAdkydKmEL/THgls2JItSjnthKojh/zNeS4psEWhKpH2pU53wBhACTUzjJLi6
         RGuuHhXhQIvxpujyOYrd/DGuu4oNN2Djn/r1y9AsW+9IIdoh4f3aobhhl7YgQsNK2IEe
         K/fg==
X-Forwarded-Encrypted: i=1; AHgh+RotG7kbX90bDMy8OS+ZmKWkCrLXrSh7AsPviJy70GQYaspLphAs6wNql9Ywmd0LY5+VqeB5srf2JB4y@lists.linux.dev
X-Gm-Message-State: AOJu0YwZws+//aEduuNzv1oAXSZ0dYqGXoj/OsxgKW3HZAy6bBZfE88l
	8n+oAT5i3oBfG+mzoVpMiNhZbwOaLJDxRmbjSKvZhxHaWt23ZdEEGM9wxn0TN3m3BDal9r/1HLN
	y/2mrPS17cB8rwBEiINd2YMKkd4/Ainy+Pn6XOhebOdq3PrL5bwmxwG26wMkJ68Iu
X-Gm-Gg: AR+sD113Zr/WkBgnmtviqA8tcGojLvoopcWeDWWtLxXJ9X8cokWNjOqkR31zmT7N1nG
	jR7k3GsJR8o6cO+q3S56uM4Sn6m5QfO2fJM/2TRTmMYO2S6x+2wFrJWVksnVMTFop+lBtnNyzXM
	FYgqUkYG4qPa1gLaEF1rRJCFse87m0JKMO4/BNbKVAHRZY0KH/oHguIEtEdHtRPsKX2/mcEp8Yt
	cHSKRcnk76lvV+ZsjF4Wg+dpRgBrRENlN62RcDp73eVMFpW+kfdQdvC9Gm2k6uI88n/xpPjYUf2
	3hm/kYUxHEUjYNigUYJB3kV+iraYgeH3inA4LqHkN8CK4eUJhxiKku1qBhVrvHZ9XDHZetYvazu
	h64pE3RazU6erWpbeKR7FIHZ4LP7dIiJCZ2g=
X-Received: by 2002:a05:622a:1a85:b0:51c:1f97:e860 with SMTP id d75a77b69052e-529d70b9700mr17426741cf.3.1785243233321;
        Tue, 28 Jul 2026 05:53:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1a85:b0:51c:1f97:e860 with SMTP id d75a77b69052e-529d70b9700mr17426311cf.3.1785243232759;
        Tue, 28 Jul 2026 05:53:52 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c492f451bsm685774066b.50.2026.07.28.05.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:53:51 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:53:50 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Trilok Soni <trilok.soni@oss.qualcomm.com>, virtio-dev@lists.linux.dev,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] virtio-mmio: add support for transport version 3
Message-ID: <kmbjsoc532n7dfqzuagbgpqawwj23cbbyufwkilr3la63akzbf@tut6umu6qwyd>
References: <20260605142921.2824-1-peter.hilber@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605142921.2824-1-peter.hilber@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX5XfznRIdsNXE
 U10rY5tH02sFoy+0n25pZBfui/UFL6FGuzgE327vKrx+P38NPhBGBI7blRUi1BjVeMQSWFws66v
 hCUIQAPMQfhJshVISzjw+wOTRnY4hhY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX6wT7KWYJzKOR
 ggFc/+siRQK+EG0jyYoaIuWhrX8wntTYbjkkNUjQNtthDV6ALuW9c7q+s8+w1Bi4h9GUFSgG7Zd
 MRYoLMhDjC9UXry1nPLgwPbs36lVPu9+6+joVVs7eqecOaMe5VfchaGv3hqrZBsPE0y3+d711AP
 MqiA9jFQ62J3gQym5mzLfJ9JmW7oiup9mo9EFnx4Z37WAnyC61QOjCjXuEKJ81ow5LJBm0zttRX
 c/S4agJ4RaNdyVUb23fA3Zvtdz/9iPK/TRwPvgRg8Kw8JSXBNEdy4lwqb7LPuikIrzb/zVTXLuc
 CuJEd1f+QlBSM0Ty1I68pU3AyZNFP3stZAXXztjGreRYTp58q83I438oZMOz2DVulzabpoZydoQ
 y/EHz8QRMc2ncoQni+kasfzG3aK5lOXWPYz6nC8v3PEr5Gj4qQiVJjqhkDKFxsedjaJbTNy1Abk
 5RvI4wHRFhAKXsIbaow==
X-Authority-Analysis: v=2.4 cv=SqegLvO0 c=1 sm=1 tr=0 ts=6a68a662 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=sKjYTbxxC-ymcgnlkHUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 3b1T9qqSE58AeT-uF-MqkA8hhMpt0f5J
X-Proofpoint-GUID: 3b1T9qqSE58AeT-uF-MqkA8hhMpt0f5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280114

On Fri, Jun 05, 2026 at 04:29:21PM +0200, Peter Hilber wrote:
> Virtio MMIO transport version 3 allows device reset to complete
> asynchronously. Unlike version 2, where writing zero to Status must
> complete the reset before the write returns, version 3 requires the
> driver to poll Status until it reads back zero before considering reset
> complete.
> 
> Update virtio-mmio accordingly: accept transport version 3 and, during
> reset, wait for Status to become zero. Keep the polling loop unbounded,
> consistent with virtio-pci, since the reset callback does not return an
> error code.
> 
> Signed-off-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
> Link: https://github.com/oasis-tcs/virtio-spec/commit/bb1dd2e1fe89b862f38f15873d835a698b196f89

Gentle ping on this patch from June 5th.

(Adding Jason's updated address, since MAINTAINERS was updated after
this was originally sent.)

Best regards,

Peter

> ---
>  drivers/virtio/virtio_mmio.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 510b7c4efdff..316f03b97356 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -55,6 +55,7 @@
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
> @@ -114,9 +115,9 @@ static int vm_finalize_features(struct virtio_device *vdev)
>  	vring_transport_features(vdev);
>  
>  	/* Make sure there are no mixed devices */
> -	if (vm_dev->version == 2 &&
> +	if (vm_dev->version >= 2 &&
>  			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> -		dev_err(&vdev->dev, "New virtio-mmio devices (version 2) must provide VIRTIO_F_VERSION_1 feature!\n");
> +		dev_err(&vdev->dev, "New virtio-mmio devices (version >= 2) must provide VIRTIO_F_VERSION_1 feature!\n");
>  		return -EINVAL;
>  	}
>  
> @@ -254,6 +255,12 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +
> +	if (vm_dev->version >= 3) {
> +		/* Wait for reset to complete. */
> +		while (vm_get_status(vdev))
> +			fsleep(1000);
> +	}
>  }
>  
>  
> @@ -600,7 +607,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  
>  	/* Check device version */
>  	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -	if (vm_dev->version < 1 || vm_dev->version > 2) {
> +	if (vm_dev->version < 1 || vm_dev->version > 3) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
>  		rc = -ENXIO;
> -- 
> 2.43.0
> 
