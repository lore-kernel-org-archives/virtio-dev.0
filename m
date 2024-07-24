Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30D1C2AD;
	Wed, 24 Jul 2024 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721792319; cv=none; b=S3dAd9/h+AmVtwYc3Swtvr7fpj3AZTHsSarj89fVaU2MnfrDVFSi1hDV6aryGjqMW/KD3LZEObpp2Pxk2ipSurld5pdoii683kCl9ZKx8KUcC4XcQ+1XCUPYhfNEeEKsAybCeP3XgoQlPo518rELZDAN4FADy4ug4tGAbjEcDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721792319; c=relaxed/simple;
	bh=vRsRJaBHX9AGWpTcYgPUKJik6E/U1RRmVWwWqnTTM+4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mem8m1RhS3XiqU9/mTh9U8wZgACqWL5n+lKzR8vh+KVdIL58Y/AcwvoqVq0R0M2dnlvLTK779nb207cP/1wddWKliaTuAOB5W5ntakqmfigam2pn3iUhWG8SFTWLf7QZrMpj2+5PIdQoT5DAo4S3Kjvu25BzIhDCJi3xS5tyybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HmD2qwz9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HmD2qwz9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NKt0FF011194;
	Wed, 24 Jul 2024 03:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:reply-to
	:subject:to; s=qcppdkim1; bh=vRsRJaBHX9AGWpTcYgPUKJik6E/U1RRmVWw
	WqnTTM+4=; b=HmD2qwz9u21JmKjvooCx+k3pY9g3/xL3FKWozeU/dV9IJhHp/me
	sVVXP+4yKY08y9wuXhNUacsR13T5WShwTyP3FhBcEBPgB3L/Vv81KsMIu84YcQiV
	Wxikx4xzUw96MFXZw+4GbH5tRm94d4MDnBZQUQhFUbdakkH6lm3DlwkUFlUF/FUy
	RLc5wjQhbcTZtkolQzjeGAkdkySPrFLzvEoilBrw79aRieB6EP+wM+1TfJk8Todg
	I51Ffb+gjXOfZvioLzhbfk2UMldeVua9H9xZm/Lw7qAl15sZx/4RmFqZaDcgqzWz
	TgwPcQQ7WQWXxmauNKh107N8Hj9tyYNeytQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6dk0pdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 03:38:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46O3cOuD006659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 03:38:24 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 20:38:20 -0700
Date: Wed, 24 Jul 2024 09:08:16 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <xieyongji@bytedance.com>, <jasowang@redhat.com>, <stefanha@redhat.com>
CC: <virtio-dev@lists.linux.dev>, <virtualization@lists.linux.dev>,
        <quic_svaddagi@quicinc.com>, <quic_mnalajal@quicinc.com>,
        <quic_eberman@quicinc.com>, <quic_pheragu@quicinc.com>,
        <quic_pderrin@quicinc.com>, <quic_cvanscha@quicinc.com>,
        <quic_pkondeti@quicinc.com>, <quic_tsoni@quicinc.com>
Subject: [RFC] vduse config write support
Message-ID: <20240724033816.GD492231@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ulQgpG6SXlIrzDWYFnW9bBxRO3EBc4aj
X-Proofpoint-ORIG-GUID: ulQgpG6SXlIrzDWYFnW9bBxRO3EBc4aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_01,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240026

Currently vduse does not seem to support configuration space writes
(vduse_vdpa_set_config does nothing). Is there any plan to lift that
limitation? I am aware of the discussions that took place here:

https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.407-11-xieyongji@bytedance.com/

Perhaps writes can be supported *selectively* without violating safety concerns
expressed in the above email discussion?

We are thinking of using vduse for hypervisor assisted virtio devices, which
may need config write support and hence this question.

To provide more details, we have a untrusted host that spins off a protected
(confidential) guest VM on a Type-1 hypervisor (Gunyah). VMM in untrusted host
leads to couple of issues:

1) Latency of (virtio) register access. VMM can take too long to respond with
VCPU stalled all that while. I think vduse shares a similar concern, due to
which it maintains a cache of configuratin registers inside kernel.

2) For PCI pass-through devices, we are concerned of letting VMM be in charge of
emulating the complete configuration space (how can VM defend against invalid
attributes presented for passthr devices)? I am aware of TDISP, but I think it
may not be available for some of the devices on our platform.

One option we are considering is for hypervisor to be in charge of virtio-PCI
bus emulation, allowing only select devices (with recognized features) to be
registered on the bus. VMM would need to register devices/features with
hypervisor, which would verify it (as per some policy) and present them to VM on
the virtio-PCI bus it would emulate. Protected VM should be shielded from
invalid device configuration information that it may otherwise read from a
compromised VMM.

For virtio devices, the hypervisor would also service most register read/writes
(to address concern #1), which implies it would need to cache a copy of the
device configuration information (similar to vduse).

We think vduse can be leveraged here to initialize the hypervisor cache of
virtio registers. Basically have a vdpa-gunyah driver registered on the vdpa
bus to which vduse devices are bound (rather than virtio-vdpa or vhost-vdpa).
vdpa-gunyah driver can pull configuration information from vduse and pass that
on to hypervisor. It will also help inject IRQ and pass on queue notifications
(using hypervisor specific APIs).

We will however likely need vduse to support configuration writes (guest VM
updating configuration space, for ex: writing to 'events_clear' field in case of
virtio-gpu). Would vduse maintainers be willing to accept config_write support
for select devices/features (as long as the writes don't violate any safety
concerns we may have)?

Thanks
vatsa
