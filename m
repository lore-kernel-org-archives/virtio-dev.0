Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA87E785;
	Mon, 29 Jul 2024 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722232996; cv=none; b=Vg8WfCbhSGm0KeXeB+7eOyVX9T0bEsDSMxHsNJR+xA7309P5pZzUMzi8Sw3m4bVGneZMu91ToRoL2WFWoAW0sa3MwkvtvrQ+/A6oYZ3q98HGleDOXNp2b6RJ1B2IXK1+ZkPpdTNHdN7phZNaghIbQ/WPqWzIuUq8wODnHDvAJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722232996; c=relaxed/simple;
	bh=9DLRauf5o4qqta7UoE6zBf34taZjHuVLg8ML3FezwFA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+M5Em182Jww+3kNnGmMXcVIBdB8XUQVa9TsMrYG3Ujjg0ZCVYUYi1AvFUVY4fBEpIdZqA37mzc6fLd9nZnig/v3pBoUq25fjtHCeV71MQRSgM3fcZNtHdzQtJm2Vnewd8fyAMBUFliF6g54vUHu06wceMxw2ARwkE4LBMaCJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MT9wC06x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MT9wC06x"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SNr8jK022117;
	Mon, 29 Jul 2024 06:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=qcppdkim1; bh=HQvK+9kuBmJfujS
	xgy6snNQiuX9tmIivG/Bwc/N+8xg=; b=MT9wC06xpAKsoQs9KC6qFL0S05hiIJ2
	0xeOZ9lhVkJY0x6/j6Rye9pWA+Y7o+sf88paFzE+TzBE8e+p50G4Ni2qa+AlyB7q
	WAyURA+igIhvEd3wvESFtW/g+H32uZK9nQhOTU0z/cFIPfVwaWDW/V4rPi/S59EX
	24ZOCGyB7a/X91EGbEUqWHz77vo1cprYmds3Hj+1kYrQ/JgltOnBnAft2uTEuiXt
	MFo9xrhZj9qjgZe1KVdbOBFvKYVh9UyALJ4THWd+wZZPBM+ZldGcpuYLLj53/f8l
	79+tb5azCfIag7/DfQUKSTbCS9ovfSObrvcQVnMS6p4Bk3JaBE1Y6rg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mp8mubxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 06:03:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46T6320s016865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 06:03:02 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 28 Jul
 2024 23:02:57 -0700
Date: Mon, 29 Jul 2024 11:32:53 +0530
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
Message-ID: <20240729060122.GA1542333@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240724033816.GD492231@quicinc.com>
 <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com>
 <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8GEwEpxRZlF7KXh8z5HYTx2UFj1M7-z
X-Proofpoint-ORIG-GUID: f8GEwEpxRZlF7KXh8z5HYTx2UFj1M7-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_04,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=621
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290040

* Jason Wang <jasowang@redhat.com> [2024-07-29 10:16:48]:

> > Without this optimization, guest VCPU would have stalled until VMM in host can
> > emulate it, which can be long, especially a concern when the read is issued in
> > hot path (interrupt handler, w/o MSI_X).
> 
> I think I agree with Michael, let's try to use MSI-X here where
> there's a lot of existing optimizations in various layers.

Yes sure. Even if we implement MSI-X, there is a security angle to why we want
hypervisor-hosted PCI bus (have provided details in an earlier reply

https://lore.kernel.org/virtio-dev/20240726070609.GB723942@quicinc.com/T/#m84455763d6b4d0d3b8df814b3d64e6e48ec12ae3


> > > > We will however likely need vduse to support configuration writes (guest VM
> > > > updating configuration space, for ex: writing to 'events_clear' field in case of
> > > > virtio-gpu). Would vduse maintainers be willing to accept config_write support
> > > > for select devices/features (as long as the writes don't violate any safety
> > > > concerns we may have)?
> > >
> > > I think so, looking at virtio_gpu_config_changed_work_func(), the
> > > events_clear seems to be fine to have a posted semantic.
> > >
> > > Maybe you can post an RFC to support config writing and let's start from there?

Does VDUSE support runtime configuration changes (ex: block device capacity
changes)? I am curious how the atomicity of that update is handled. For ex:
guest reading config space while concurrent updates are underway (SET_CONFIG).
I think the generation count should help there - but it was not clear to me how
VDUSE is handling generation_count reads during such concurrent udpates.

- vatsa
