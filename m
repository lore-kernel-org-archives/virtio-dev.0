Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6F236A73
	for <virtio-dev@lists.linux.dev>; Fri,  5 Jun 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669841; cv=none; b=dD7WwBeyMr/KNGECIRUpDSk94pOHtSso4E6u40ffxpiCpXU5CKOLzqEDqJXeJgtUrfRFMm93whYYDOyQTO0c8ijDgRymOqesoxOJcTL9aBK6n6xZczJthF+IFoKmYUoEFkAc2VMWScl9XSnnAC9qOwFJalP0roP+sA37pxpavKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669841; c=relaxed/simple;
	bh=EVj/w6iK3+b4kNl2JDaF+zi/oZ4jg0tk/C1v/bSAc1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1oJxwtc+mGqE1y9xbkZwpo0r0KYZ057fGPv0UysGSu0dj+Kl22kJ4sRJOepXPQ4hMfmyob6UOh2M6/hv2a7NAUQggvN3m8yFKBSTVIUCT/TBjdKXgXYneDC8rauDuJ/UWc5uGojAivhn17qYtO1e0PF8LdyEwL34qLyzDaKYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLCqL1r9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P2L9TZiY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLCqL1r9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P2L9TZiY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655DRCCw4048099
	for <virtio-dev@lists.linux.dev>; Fri, 5 Jun 2026 14:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YYr53TWlFvQ9X3G8WUw05dDowvGVXxiHZ6r
	UrNQhMqQ=; b=XLCqL1r9PEVlz/K281DECkdMMmGaJHtmUG9SyD2N+w8KA5Wv4Dl
	kRBCmlw2a6NZuVTT/sbMHfz8qNOQo43ryWwkO/V7vl2N5MDj3yBWe5uSgZKC9FKD
	53P6pMshkpq+updZXJ1KhYi95hzrdVSYoe9GVGmpNi7IXtuRka62vRfzLSl9udID
	nLIUz+I+xZabscPNnwvQx+OzaqtWeVPWNbdpPxkdbuQL9hKg3rtnZt3HYHp8DlDi
	gwVLsHkRhTupqBf9NqVRChl7RSRk6sZ53rEivBKYt/RlXoZPga8Z2168TCcMcI39
	xhd4FXc2zIR+BrXkFdyIJGD15P6wnWBBR3Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eksf8humg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 05 Jun 2026 14:30:37 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cfdce65690so774642137.3
        for <virtio-dev@lists.linux.dev>; Fri, 05 Jun 2026 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780669837; x=1781274637; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYr53TWlFvQ9X3G8WUw05dDowvGVXxiHZ6rUrNQhMqQ=;
        b=P2L9TZiYHJ2N//E2i3fDNq6XsY8C/tZIuodGs0fmMWkipOrV+7/4z1ePmwrca4DVSF
         i/w43HO4HXJq4k/kzXOrPAoxFGkoXMOHpt/y1j3B7VvmqH0NRw89Ueo0XqVibA1Xi9Hy
         gfbPxhIwB3prk57+Tfi25VZiU9TYoLv1Ga65wbBRvXtxUb40m3nt9tVifMD8xdolEy2A
         5XtS8SWawsC38YU4HRUKH1SZ4GliqlLCNWTSYZDl4lCm1QoyZ9UJaTEDBfFIYZCKn1eU
         npmLnv1LfdA+7rkbEXApTFARf9I5gZYjnv4zpo3wl5+/6moGL6qFc+zSpNx8z1m0R+uf
         eYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669837; x=1781274637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYr53TWlFvQ9X3G8WUw05dDowvGVXxiHZ6rUrNQhMqQ=;
        b=qkUyR+A4BBidgxoKZQK1fW+3WUYxHau/38AVTPkTJxF1s+3lLwN5PXu6rAqcZ5WwFp
         2fEHKzGlgehumoaTE3/fzgOZ/zwo12lDN3wWbLIWNHdyZhGqFcWS++2zmda80crlIHeC
         yVRPmW/MOkg6hYv0XuvDVdg315oFv9akJh5oH5ng8BaHqRVBH8uqJYsd4pY7uRZ69Qau
         vx5tVyzpXYsJAbEpYd8kA7WMxv6exU/AakU55ca7yaOHxEr93kELAPYIkJQ9VY+BnKJs
         r9N1DAdq9y/BYhsyw5VCqNWI+Z3Cf6EMKnTZBQTHR0b3kwDc+8Fk7Gq43eg0Gjh+Hj+1
         Vr5w==
X-Forwarded-Encrypted: i=1; AFNElJ/CYkQXN31jSuMQoDbDpl3u5VlFY2pJ1nE5/7FXNft+UpwkeUh27AxXAb/pk6XP+OAsVKAb5yUubYXb@lists.linux.dev
X-Gm-Message-State: AOJu0YwCGiFwxviJprOZyOpO4RyiwrCnOQYNhpxJcsbLTUaJEe3D5awq
	fjfrlwxhR1ckX80G/RlSPZvpPNcr5ujBzdy5aTgPdjocrziAO/MfE1CrYkaSag5qFT44YHAKKIh
	DjBZYGkv6Ok36Hi71+YqHpj4QbnO5t2uzWu2j3WOKIQel3kHzpKYR9qkdjNZF5Rcs
X-Gm-Gg: Acq92OFrSvwgLbsjGi7RpfAec0O0NQRWjcuUJIlPyVSG+DuxQNsoD0A+oCYrEWYbwIm
	YflTXEGh6elko7dG7otGDYNTVDEVTp9ttlkI6UWuSKKWqaRfb6ZpjSqTzdgBdCjm/RrDQXpmeM3
	ilf9HAJqtsZY9x3K0DsUVdkVkn/26I1cqnZeyK4cMUhCCElJu//YHMS65FQ1SjiMZftQ1n1JUjF
	KGd0PljRJR2FINuFMedD8gjdOAhvrwPIAJcgbzbT+e1cY8kO3eC38PtLL7ywZ/m5d7Q1V5qj/1F
	c+8gyr4ivcsQ+TZuD95gF+0Y+WU/lFyrlTVP8b6KXHQBXwotTptq7pGBycorTLcKwept1440uqE
	gFiTPWBE9ZPb3/L6njARM32HE4btaas8QoRyCIg9fbs6jaBrMD4/1xtqdepVe8rg=
X-Received: by 2002:a05:6102:5490:b0:6e2:501c:3c93 with SMTP id ada2fe7eead31-6ff0eba884dmr1941949137.14.1780669836894;
        Fri, 05 Jun 2026 07:30:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5490:b0:6e2:501c:3c93 with SMTP id ada2fe7eead31-6ff0eba884dmr1941844137.14.1780669836424;
        Fri, 05 Jun 2026 07:30:36 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm3814609a12.0.2026.06.05.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:30:35 -0700 (PDT)
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Trilok Soni <trilok.soni@oss.qualcomm.com>, virtio-dev@lists.linux.dev,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Hilber <peter.hilber@oss.qualcomm.com>
Subject: [PATCH] virtio-mmio: add support for transport version 3
Date: Fri,  5 Jun 2026 16:29:21 +0200
Message-ID: <20260605142921.2824-1-peter.hilber@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE0MiBTYWx0ZWRfX32HKM/AZuWru
 IzF+eS66o6tNPJaj3sSDO80Zmw2XpOqcRlKCSpPm2fwt2SEUWyu1ir0/3pSaEE2WZcex+2Gg0aP
 f0ZKP8xtiEx8ueYDlNWZgYghumpZHZ/MV+YRs6WRQKN9BDzfTh5p35sjCmyVb0TsT+aWO04O72j
 LsRQzEwSLhj1W0uOqvmdAafvkzoKMj2gUgZjYRoe67e82WhkeSbWc4hvk30CHs995d7PgPsqdca
 enqN1ktqVsduuXqdHmEDjmkRaezi2SH/Bj3AvlD/u8wGRg34bMZMJzQSjJ9AqARdVId3XDyaDz+
 NNbmbf4TriVY8XXhHK1NrzmaCNOsmvnTfAL5XvMNJUoM+A5KIfYwzgIFipfFKPI0wz+AmokKfPu
 V0u70JJw7h0zlNNKv5qLHpuZ4gqoJ/L//s8lYJWjz5hhqoe8Sdov8EuDwxjqSfY2JGKln/tn2+h
 PMLOUCj8CK3opEVvJeA==
X-Authority-Analysis: v=2.4 cv=K8sS2SWI c=1 sm=1 tr=0 ts=6a22dd8d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=SLj1U74zwwqa45oC7IgA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: enTlABooH0kRkMZIXy5rb9TiEyM5OAxy
X-Proofpoint-GUID: enTlABooH0kRkMZIXy5rb9TiEyM5OAxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050142

Virtio MMIO transport version 3 allows device reset to complete
asynchronously. Unlike version 2, where writing zero to Status must
complete the reset before the write returns, version 3 requires the
driver to poll Status until it reads back zero before considering reset
complete.

Update virtio-mmio accordingly: accept transport version 3 and, during
reset, wait for Status to become zero. Keep the polling loop unbounded,
consistent with virtio-pci, since the reset callback does not return an
error code.

Signed-off-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
Link: https://github.com/oasis-tcs/virtio-spec/commit/bb1dd2e1fe89b862f38f15873d835a698b196f89
---
 drivers/virtio/virtio_mmio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 510b7c4efdff..316f03b97356 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -55,6 +55,7 @@
 #define pr_fmt(fmt) "virtio-mmio: " fmt
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -114,9 +115,9 @@ static int vm_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/* Make sure there are no mixed devices */
-	if (vm_dev->version == 2 &&
+	if (vm_dev->version >= 2 &&
 			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
-		dev_err(&vdev->dev, "New virtio-mmio devices (version 2) must provide VIRTIO_F_VERSION_1 feature!\n");
+		dev_err(&vdev->dev, "New virtio-mmio devices (version >= 2) must provide VIRTIO_F_VERSION_1 feature!\n");
 		return -EINVAL;
 	}
 
@@ -254,6 +255,12 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+	if (vm_dev->version >= 3) {
+		/* Wait for reset to complete. */
+		while (vm_get_status(vdev))
+			fsleep(1000);
+	}
 }
 
 
@@ -600,7 +607,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 
 	/* Check device version */
 	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
-	if (vm_dev->version < 1 || vm_dev->version > 2) {
+	if (vm_dev->version < 1 || vm_dev->version > 3) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
 		rc = -ENXIO;
-- 
2.43.0

