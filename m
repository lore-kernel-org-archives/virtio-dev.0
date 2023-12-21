Return-Path: <virtio-dev-return-14195-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAB6C35274
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 11:25:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A01F72B144
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 11:25:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 838FF9865FD
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 11:25:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6B5CA9865B8; Thu, 21 Dec 2023 11:25:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B4B69865BA
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2023 11:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1703157910.325000
X-TM-MAIL-UUID: c35b5a5a-1d9c-4968-84ab-801ead33518a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDOmsQ0iR6bhxp/IHcL72UiI0OuaG+AeZ46Vds3+RkXihBFvOwyYsFS2u983VN/SIeWxEqZDtjJbjAW3rPi0Hi3XZcUmkwcDjH53uif/bXKOBXtt/zLEsuyXNCWnYlSb+vs91z01/13i5sMCL0g6Xa3xKQJBfgdo69uMXMAugfwSDSIUMJkfS0ASiUvsNd02Bv/0iVy8581PuVTMAP1M9w61oHtGP6HuUQLc/ROLMtVCL3KMW13O/yWGx/RAgqgHKtMYTOMRHse7wPStT9BP9vru5imj2wBRE5wD9TvMRNbfS3Jz9eq5uTRU9+Q0JisQmoGAgEKgGRthqJc0xysI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjUdtQXXDz7805LB6m2n0tQTDf41O7FSOUrt2ydyMzg=;
 b=e5vRJle0ERAJb33/7niJcTRhl5p50ItHngqJdjJsEplFx1S9Ti1HfCuPovEY04IfeiYwBI4ttYjdP+Pwh7vAI/lZ6TpdAqRXs5T4LiO2VAkjJrhgeO/IslXvb525c7tA+1/vT/H4BnaD43jszFIOG9w48HDJ4qlOb23vGGODiEA5t6vgayTBsen05iX6qH5GpAIOSiFOMo5G6CvuMiZGtEKphfv0AHA6xfCLutGVdXRc+Al+lDKlnQ4rpH2wX63b6LNBGMU1XRKRK4gkNNCnhWsFXDB9KFW60Pu4RO0gZ59XkmjoI1JtQNOpBx55YMok8vgVmkgm7APyDdRf7wFclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <95dcd2c7-4b5b-4b04-8748-e9e65374d356@opensynergy.com>
Date: Thu, 21 Dec 2023 12:25:07 +0100
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com, broonie@kernel.org,
 qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20231212033317.22198-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::13) To BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEUP281MB3414:EE_|FR0P281MB2495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0758b864-04af-4682-962f-08dc02177d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FQX4OT2ZvKJdo9E73C0ZEw/DT2ECjq1UwjfNyYkplxTjY+SQ1yEUareqtMb44JB/DNQ1jreZbjq2zpFhmH3MtS/h4a34lgqPpRc0xMONNlKVAwF2863XQyq9HJpc5csp1KUicfSUvuoGv06oKAlfdWPj4rEMz+DeCgXHpo7WcqHuZQ+H8ebrqM5MFOl/Qeh9hUexvv1wL+wLWNChAsPj2H8D4w7lva5mhOtEgulkvpLlr6KvrJgmZQlpAz+u7N3Pf6qsMjTZR7dxAdnCWEJfiZaWRGSyy5VNNTUFt6nfrbeIOhK/42VhuCG2Fkp4kGYgJr+rDDF2MiUxGMxxUPVcF2nZhhKdaOlOrhfBawkAaKb4A8G6n22INYLxELpalyMPBnlMLyFJC5aQ1WVBijFcMQiDOYQf9rKkGNy586w0kZBLlwRA6/alrSF7SwSYaNWtgu7UvuF7Xy+B1eBzP6XP7rljkrhJ5qLcrFbEQNrDYANEjWR+iSxgaZ9ceokYOvgVepVbj2ZM9drF/yI6B7Z2l2duAGawRCF3EnxEKYZjrV57y9e+a0nHd3L8Lpc/lfJPp/Iw1N+QVfHONXIbsHmGlCm8qT+KSC1h8ARwUebFiZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39840400004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(316002)(66946007)(66556008)(5660300002)(66476007)(44832011)(31696002)(2616005)(31686004)(42186006)(4744005)(2906002)(4326008)(8676002)(8936002)(478600001)(53546011)(26005)(36756003)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGNUclNRSHJxNXVYbnFyRW9FUmZXVHV0eDFOckU4enpyeUlmci9zaWs0N2pQ?=
 =?utf-8?B?UEE1clRXM0drcmhMVjUyQXk3ekFKcHJ3dnBRWGRVWVNhck1JL01zcU1sRVND?=
 =?utf-8?B?M3l1WHBITmpWdmRFdVRyRm5jTFNnSzJyVXpyeFpHUlZrNk9pUWFuVlpQeDNs?=
 =?utf-8?B?RFhsMUdVcDZMcnFaNy8xTFpCUk1TaVVjb2VyM3BSUXJpSHdIZmN5V0FQRktv?=
 =?utf-8?B?WnRWSFNZNDhta1NiVE1mQVBIK3lwQ3c4cUQ1b3hZWGMvZXNGWWt4NThaRjNu?=
 =?utf-8?B?dnNVRmx2b1dnYzh4elpGdnZwZFhVNDdqWDdpQVBJRXc0ZkJ3bUczNzEzYjJ6?=
 =?utf-8?B?aEFEYTREVlRJSUd4Yk9OUTdRZ01oYUxiRWdxcVNWdGdLMGtYL3Z3LzA0WnUy?=
 =?utf-8?B?VElZYS9QT3pCdUlBYS91c2E0TjRWeWpRMEZUbUU2NGRlWHZ6S3I1QXFnYVlX?=
 =?utf-8?B?eHFITlV6MzEvNFc2czA3bmlqUnhBMFBCdExLdDY0VnUwRkNZeW5vMHhFOGl4?=
 =?utf-8?B?MG15b1hRLyszelZ2UGR6Nm5SSWpoSGdqK1M5bWdWTHRTdzZmTmNDdzkrcG9n?=
 =?utf-8?B?ZGhBOVFvRnFTUEc2bUtERE5zeGVNa3ZZMk1PSEppd2tJWGFqL2hUYXkwd1Vl?=
 =?utf-8?B?WDN6dHJyS25oaGNsZ0hWN3JoT3JGemJMM1pXQmg1LzhQclRsUG9GVHAxa254?=
 =?utf-8?B?eXJTNzJ6SDJIV2hHTW4yU2UxM2gzVjFlK3pMZjUxTXZ3UWRkOStBOFhMOFlR?=
 =?utf-8?B?dk9nOWQyc2lac1V0UmtpaGdtL3B4aFh2cFpJWVRKeU9JQWF6Q2o3NGllN0t2?=
 =?utf-8?B?S3A4L2FIeUNGT0o4TlB4cDNiMTVJSnBtT3lrei9lN1RSNklFdGV3bnBYM0pt?=
 =?utf-8?B?NEVwZXk1blhQQkl3Yy9qWVpBL2sxcHBzQ1VmUk81MkVFZnV6ejUxWktYaTJL?=
 =?utf-8?B?TE5UR1NRbnpTajhacXdWVWJWWWJNNjJlSHJqQjRmRTcyVlJsaE1iVVhaZ1Ru?=
 =?utf-8?B?aW81ZkJzNXNxVldKU2JhOFlYc2NETzltL2t1ZjlQREJxVGFEcCtIdlhPaHdw?=
 =?utf-8?B?MnZWcmQ2bVdTM01VS1d5MkU3Q1o0THc2S0YzSUhyd1FwUjVVQzd4dTBIdUlF?=
 =?utf-8?B?VG1VUWtWaElBbXU1dE0rMUtzTHJQZzVVUkppTEVwYk1BV1B5U3p3ZHZuTVk3?=
 =?utf-8?B?N1hJQXVzMW45VXJlYTZBenpNR2lBSitYR21vV1RSb0pkeko1eFlXMy85cUNZ?=
 =?utf-8?B?Wk0xc1JmQ3pZMllsWWFqbEUzMzE2TWdLSUVQVm1Nc1ZEVXE4Q0F3M3FibXhr?=
 =?utf-8?B?ZmRTb2R2VWZaKzk5WmZtSUR4aWJmeEtzMDhjbWNidm84c3dzSWlWRDVXM1Vo?=
 =?utf-8?B?aDM0WnFVNlRuMVcxMUo4c1I2RGRBa3dHYzBSQzRnMTNwd1A4OU4vaFdVVTlu?=
 =?utf-8?B?dStnQ1NVVjdpaEhTTExILzNDZHliK1hMMG9wcVdMOTlEKzBCMFcwZ20vZTMv?=
 =?utf-8?B?cHZRMFZ3UzUvSUpiTGFORG5NVzBiVkZpVEZBOG02VXBVRzFSSzF3aFhmcDF4?=
 =?utf-8?B?YTZnV0RtR3lqZy8wZkphS0NiSDVjR2ZEUUVaUXI5SUlZUlczZkJPRnE5bjFC?=
 =?utf-8?B?ZzRIdVJsOVM2a291dlRJLzNzOVFubXllVE1tUXVQRGQ3VW4yZ3ZLNlpJY3l5?=
 =?utf-8?B?dmlaZVZqbElUNU4wTDhKSUw5V1d5aFE3dlg4QnpidXFLYjg0VDJZbjVQRmk5?=
 =?utf-8?B?ZURrRmhzaGczTG0xZm9Nc29QbEhmZUhJSk11ZHQweWZwVzg2R0t5YnFGdXVZ?=
 =?utf-8?B?dkYzakZYY2laM2hqSTdybWN1QkhXdGZSMVlCb0xOQ3lNVGMrWkFIOEdtaStL?=
 =?utf-8?B?Z2taeU1ZM2pYK0hPU2NoYW9PeHpQdDErdG5SQThQTkVnS05EbGdXcVljWEtv?=
 =?utf-8?B?SnBtUlFaWENON2h5ZnZwSWtSZ1IwZWJPWTdQUmdoSU94UHZ4MGRKN1RzN2h3?=
 =?utf-8?B?ZmVGTjlqbHVoOEVEOTRnbS9lZVpaZWh5Ni9md1ZTNUthUFpOaFNHcWkwaGY5?=
 =?utf-8?B?c1dPQ0txdXNxUExKVVhzZThoZVlYM3kzaHJJS21sakluLzV0WnRaNnhTUS83?=
 =?utf-8?Q?sKWo+LsOqNXbdIvUEiQL4ewL2?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0758b864-04af-4682-962f-08dc02177d3f
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:25:09.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlfFtjuQSEY+DElalus3Xu5XUGuJEB5Rd/jV4qsAV2cc2Ksop6zMTAscgTbPPKtKpepBzT36cUuScWhc1/JHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2495
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28070.007
X-TMASE-Result: 10--1.487400-4.000000
X-TMASE-MatchedRID: +c13yJDs9035ETspAEX/non73EnA6dC3lR7tN56aWVW0ErHmx4qgLEzO
	hWjmaiyeQlVv3dUpKWWgvcO8PQduk3UEZMy/KyS1hYRqfRjTw62VmuhG06IIbYhlQKYkSwK5yZX
	qYTcVmMXfXDU2ciEUMsKjGRQnQ81haIn7kYcazIMk+VN5SeE/CkiQSPZ/ZWuhWjsaYI4lh3W+Ij
	sEEOIzYg+wWNMS8DQDoDWYr1G0/JbmZe20hO5BqnkLHUq1/6Sq
X-TMASE-XGENCLOUD: 3f082969-fc72-4f22-b5cb-156f7974197e-0-0-200-0
X-TM-Deliver-Signature: 415D6FD491C11E68D5553032260EFF25
X-TM-Addin-Auth: A6jdZHRU+NB350VWOtmmChSVG7iXvIQ+LGaHWo8Dl9nC2oowhjxmLxubg0H
	stSI1+cdnvVbncOadacHnXVnW4daK6XEKOMPkCoYnLOLpEAvSr7I6Qqjemm+K/CHvyAQBJcL8/Z
	8sWY0wSX0rFLSN0XPow9YF0Qk7km9oE0Oa+SYScLBlHAQA71MWIqqjRs2Gh55vkixos9YsoRLIp
	SKb8FAfE2auILF3lp660EdzUr7RIGXqJ8UW1nzWlv7Uaz4RcFBJIPMM5WX/krL5i23S+Tysq269
	otcozceIzpfaVXs=.oQqrQ4Tye8iSvEg7UCb04P/v2Vu9REB+HXqvW9wyxIUvsoQcBBz+d1fQ0c
	dQOkW5OGqO0QJgJcgSsxQKtjCKKIIvkEyrUaA67qaqH261m4QdSQ1FPVd31fuTZSCfo1+N/lluq
	Vm54JAC786JqX6llRsdhQd5D7GmHcUS3EnwA+nphuL+UsEwUtjIsKX8b9B+AlcFlrQ/PaKh2jyE
	k0ww2xAo33a8NUl5WOJwywQGt1KaUaXb141usXyb9eqQ9ZJmnsn9rH/ovw7TcZ26XGgS51DctZj
	ehLGeq6LHms8X70mwsQvXyljv+prpNgpErvfqLRDzjiqk1poo4uROGCc2Qg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

Hello,

On 12.12.23 04:33, Haixu Cui wrote:
> +\field{bits_per_word_mask} is a mask indicating which values of bits_per_word are supported.
> +If bit n of \field{bits_per_word_mask} is set, the bits_per_word with value (n+1) is supported.
> +If all bits are not set, bits_per_word can be any value from 1 to 32.

"If all bits are not set" is not easy to understand as it means "if no 
bit is set".

You can of course specify the value 0 this way to make code more 
complicated.

To make code simple, 0 would be not given this special meaning. To allow 
any value between 1 and 32 solely the value 0xFFFFFFFF would be allowed. 
Which is already possible now without this additional sentence for 0. 
Simply checking whether the respective bit is set in the mask and done 
without having to add senseless additional code to handle the special 
case that the mask is 0.

Giving 0 the same meaning as 0xFFFFFFFF brings nothing except confusion.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

