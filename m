Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883FC17B51C;
	Fri, 26 Jul 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997753; cv=none; b=f8TGBIOumdx88sWvIcZf7FqYvYyyUWNN8R2A0JUAC1m9dIw8faeZbpRW/JaP8g7/H5pPctyl8BxzzHsjGHcLkSMHHwX7QW1TcTlCjrkMteiqIa4mzQ6+ygIhvG4EpYwTss3RXlzqw0RffHHjkg7FeOy4pIOmP18j1SCdnRJmsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997753; c=relaxed/simple;
	bh=GD7YKwAPpK48Ijjvs5/urXGwm6yYjZ35nyB0utU9De4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7oOSEecZTh7kU4hPz3Kb5eO8wEgjMsTEcLK9yuA6s8oVtm2LTrrvVlOYJPqiav0g9s+q+KKt8U/LxNPvy510/SgDo797jQ3r6finzH/JelT5ZxaOBbkgau9rOaO1GKJ+YmgSrq9B9v54m4xVK12fxzXrOkaoGC1yV7nMjCInvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OqJGqZB7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OqJGqZB7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBUVAr027304;
	Fri, 26 Jul 2024 12:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=qcppdkim1; bh=fIGfmmpaBP6C25R
	n103boy+b/i1AZpOQxxgmmpvMNCg=; b=OqJGqZB75N/gYPC4JKtjK6UhKRuTh+Q
	EaiUxxsoVUqAoszkqZphnZ4BoTIxlSIJbKBV8VNqNMz4BQJmoCLzrebunbiwTuxF
	zOhI8jaMp9aIzHVIgQF6eUi8GISl2UN65OivLqsDLXRlN+yXoDhR/xjH3WRbNLm+
	P02B2Ycbf+8AvjuKXyEbfBmTMArikR3jDvWEMkmcxRMed1wld8YIcMcgte1yI8Cc
	zn1bYhQuSZD0XYux6RMyZOX5aUrOsTvTkUios4zdRRiQEVDH3TKMeW06yXAKZuH7
	LRfr3W5psEWToCbfVrMS6hkDvQmE/KZQEF/iSUHJxlKGHDJ6b4tVgGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1tthejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:42:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46QCgKVa001537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:42:20 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Jul
 2024 05:42:15 -0700
Date: Fri, 26 Jul 2024 18:12:11 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Jason Wang <jasowang@redhat.com>
CC: <xieyongji@bytedance.com>, <stefanha@redhat.com>,
        <virtio-dev@lists.linux.dev>, <virtualization@lists.linux.dev>,
        <quic_mnalajal@quicinc.com>, <quic_eberman@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_pderrin@quicinc.com>,
        <quic_cvanscha@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_tsoni@quicinc.com>, eperezma <eperezma@redhat.com>,
        Stefano Garzarella
	<sgarzare@redhat.com>, mst <mst@redhat.com>,
        Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC] vduse config write support
Message-ID: <20240726124211.GC723942@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240724033816.GD492231@quicinc.com>
 <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ot3MdhDonmgZL1gntupZtCNvGbpWfOM6
X-Proofpoint-ORIG-GUID: ot3MdhDonmgZL1gntupZtCNvGbpWfOM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260086

* Jason Wang <jasowang@redhat.com> [2024-07-26 10:47:59]:

> > 2) For PCI pass-through devices, we are concerned of letting VMM be in charge of
> > emulating the complete configuration space (how can VM defend against invalid
> > attributes presented for passthr devices)?
> 
> Virtio driver has been hardened for this, for example:
> 
> commit 72b5e8958738aaa453db5149e6ca3bcf416023b9
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri Jun 4 13:53:50 2021 +0800
> 
>     virtio-ring: store DMA metadata in desc_extra for split virtqueue
> 
> More hardening work is ongoing.

I think above change is not sufficient for what we are looking for. In
particular for pass-through PCI devices, we are concerned that a untrusted
(compromised?) VMM can return invalid attributes when the confidential VM reads
the configuration space. These are PCI devices that may not support TDISP.
Hypervisor, being a trusted entity and controlling the PCI bus emulation
can ensure that the confidential VM sees valid attributes for all devices
(physical and virtual) that are enumerated on the bus. That's a key reason why
we want hypervisor to emulate access to configuration space of all PCI devices
enumerated by VM. That I think necessitates that hypervisor handle access to
virtio device configuration space as well (even if MSI-X obviates the
performance arguments of hypervisor doing so)!

Thanks
vatsa
