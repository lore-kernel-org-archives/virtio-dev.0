Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92A176258;
	Fri, 26 Jul 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977588; cv=none; b=e0OBCdcX53NJKvlZ37EbfoqOMAgNsjHYkbpMdhpmwwkBY6hyRr6PVR6uBt9myqluatNs1jlOVxN7ycUVRJM4Bx4D9TAx/5heOVVuVqNplcFrpe3THh0fT/XD6Q5G5uLYZ6ZP6MlCi2UXvnssEMnkyZKl7sLoH0B4Rjw8AsQMu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977588; c=relaxed/simple;
	bh=EHfUSGlUNkcK+dPYw2Ob7hV6kqQ1OPpdRSAgp4VZdgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+fHNnQTM0dQSdHaSnqM7xDFC6kb6s1Iidl20Wi9YDm3B7ww7nllt+1SMzqlzB4Quchb+IPqEZaLd0iWjMgifpPxar6kVI6quOAsvopTVYXs50AjizLxjYZDhrtTCo/FE4/SO4pScRVuh42Abt1YpIAUPYmHg2Xx1EpmqTqY6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QeFUZeGk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QeFUZeGk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q12fjX021414;
	Fri, 26 Jul 2024 07:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=qcppdkim1; bh=LSf+RFBcjVoTCnd
	B/jGvzy1mcEJ//Tpjk1jblpLXZEY=; b=QeFUZeGkoI1mvw6UoO3rskjhodB35fh
	/OY20NRkODj0npG5/+E+HTBkiGEfuztuPw/4xR31nCim9bvLkesCbEsvqKOFUTmW
	Ls43ZCke53NGPw9jBqo4Lw7VD/EeVzXP1AdOwpqZRbq9I80E+byLEzNgvcFCoTe6
	HnwoaQz1R7xl7yGVEEULAvGcZn4RybBlJb+fTyG23hwNaFcWIh+5K8Cll9SZ1NB7
	R0/vvGWLzCn5FAqYkGJQqIA55YVNprs+M8YqzNKbIFuXu3BCH8jh6fNNaq9ugPDh
	5Gwc5lBuGArA1Fxpd9qeAfn/kUHMaBpYPimC7tzrYxcILUBd0cJG3Ew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1sv0mus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 07:06:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q76HDh025217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 07:06:17 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Jul
 2024 00:06:13 -0700
Date: Fri, 26 Jul 2024 12:36:09 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Yongji Xie <xieyongji@bytedance.com>
CC: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        <virtio-dev@lists.linux.dev>, <virtualization@lists.linux.dev>,
        <quic_mnalajal@quicinc.com>, <quic_eberman@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_pderrin@quicinc.com>,
        <quic_cvanscha@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_tsoni@quicinc.com>
Subject: Re: [RFC] vduse config write support
Message-ID: <20240726070609.GB723942@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240724033816.GD492231@quicinc.com>
 <CACycT3sGqd7jT2--Srt2de0gDPs6+AE9vMgX-ObBgKoZoqoBJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <CACycT3sGqd7jT2--Srt2de0gDPs6+AE9vMgX-ObBgKoZoqoBJw@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G812M6j55Dyv4ijOjL4iCHCdYs3cw4hQ
X-Proofpoint-GUID: G812M6j55Dyv4ijOjL4iCHCdYs3cw4hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_04,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260046

* Yongji Xie <xieyongji@bytedance.com> [2024-07-26 10:37:40]:

> On Wed, Jul 24, 2024 at 11:38???AM Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > Currently vduse does not seem to support configuration space writes
> > (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> > limitation? I am aware of the discussions that took place here:
> >
> 
> The problem is that current virtio code can't allow the failure of config write.

Ok got it.

> > We will however likely need vduse to support configuration writes (guest VM
> > updating configuration space, for ex: writing to 'events_clear' field in case of
> > virtio-gpu). Would vduse maintainers be willing to accept config_write support
> > for select devices/features (as long as the writes don't violate any safety
> > concerns we may have)?
> >
> 
> It would be easier to support it if the config write just triggers an
> async operation on the device side, e.g. a doorbell. That means we
> can't ensure that any required internal actions on the device side
> triggered by the config write have been completed after the driver
> gets a successful return. But I'm not sure if this is your case.

Yes posted write should be fine, as long as guest issues a read as a fence after
that, which needs to be a sync point. As discussed in my earlier reply, we can
explore injecting surprise removal event into guest where the VDUSE daemon does
not respond within a timeout.

Thanks
vatsa
