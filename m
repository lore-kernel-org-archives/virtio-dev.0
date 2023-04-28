Return-Path: <virtio-dev-return-12477-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F7AC77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 07:58:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 98CCA330AC
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 07:58:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67D4398668D
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 07:58:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 50692986681; Fri, 28 Apr 2023 07:58:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F78D986682
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 07:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682668672.670000
X-TM-MAIL-UUID: 7abc3777-223a-46c4-9714-37777ddb193a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZvxIRqL1hgOkop2lFFtGKNePkgEBaPcXDv1MV4MwLeUtP3Km0OtVpKQJdYgeHMOshn2a5QPd2XPL7eRTbMbzoK2BpKv/tUY0FzXgjDv0rIBRZXqoWmSfZlAYAe7Hct2NapVRvSZ+Z440AjPVaM6BKFk0TO7cgeEscVyMBUAbwuuXTpw8Jv+K8tMvlIVlrG0Fim1tJ20V5NlWzN5ytgYKp8x3ta77I3zX4N9KtsHiuHn/355/XvkZtRteu4dwBCZev4nJZnFTvl7pxSRnXOuZEHBpsmfVjUCFy9j1Ry40SMv5mDgu7jMnySP+0/FtftpeJTnz1LQKHTt/lFpD7O9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJs65ECAcd2wQBrqqRw5Lcp7gnUDIWt+lnvdJJMyq38=;
 b=iT1/RDsYh1LUcb3h1qWRcCIdiLauGcTxYtHG2NchwFOcxul2+1WXuTDEnux2cLL82bCe/rnTmJCwSnv6Sf4jafF0trrqsey/VIF5CkisdhlS8zfyWhSeFHdVswrbYATQq7meZeL0ChhAJvmYb6/gMvPEIcqlvvmNw8cIChDJB8wIaO+RLp+C10k3rKn46dtpHq24bIbV7tN3mU2o/fOQXHyJykrHUuMh+Qw4QvcLdiVBWj3ggknVnH5676Y+Ij9MAhMyz81akexTM4+qj3+adB238t/QWMVIxzYKjNPUBOGOIki5LjOSH8Hgp+uuOQKoCOGjvyHuBcRQpi4W04U4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <d0c6a175-7225-6527-0794-ae31f24e6be0@opensynergy.com>
Date: Fri, 28 Apr 2023 09:57:47 +0200
Content-Language: en-US
To: Alexandre Courbot <acourbot@chromium.org>
Cc: =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bgrzesik@google.com>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>, Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, "srosek@google.com" <srosek@google.com>,
 "zyta@google.com" <zyta@google.com>, hmazur@google.com, mikrawczyk@google.com
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <CALgKJBqKWng508cB_F_uD2fy9EAvQ36rYR3fRb57sFd3ihpUFw@mail.gmail.com>
 <d83a8f62-a2c8-8f8d-46ed-0d747daca4d3@opensynergy.com>
 <CAKxn3ec7nDy9B0nyHUg3GfXt_oktrC91kB3QWXM-sGh8ectE5A@mail.gmail.com>
 <a4bf7c00-4249-cd67-c183-31cd7c019a40@opensynergy.com>
 <CAPBb6MXjfPAeSaSE=XRKNjkAJeS8s6EGGuSypkUbGvXUmZcoRw@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MXjfPAeSaSE=XRKNjkAJeS8s6EGGuSypkUbGvXUmZcoRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::8) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB1688:EE_
X-MS-Office365-Filtering-Correlation-Id: 52226068-ce15-4176-f3f3-08db47be43d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mnXOeQIUQbl71qR7GAkIVOM9EqUPploRpA1DqcjkKXjaRffk2HB1J8eFbSsszy4QFieGxsYxSR6ZUCYeaboVUgVNWUdoGBU+QHmRmq+zxmKaLPJ3Gc4o9Av2PcLlvAkoU+QDjuNw4oKTktye4ueR3sfi5MGyOylQQ5ymop+Y/JgKDW8VcTc7CU8GgpnyX5AiPeZ8LNLo8RbZHvZkMhanqSC8M8EU1jQmazhcCQnT7rpLc+07dlhY/m/2Ct+mgFJWEXntvS08MBQU9Fgi4T3M/gwp0hRAhC/bLCP3KfMgVVAScuXtkorbgGmQuwKs7PGMsiJI7qkS1SX7loTUkNo4PFulgd8uq3FPIVcM3iDSwiDU1Hr/llHimM/oT2DXj2/Usv/F6XCyYVSYjv3tbxzC/pawtZqo3ptd9ibZzMdt3cs7+FFp03+5lx8q/Pmyzy6OA8oEB6q+lRkti2xa7dIPo7CjDBKE5l8II4V6UeJY8Uyf9rBUlmE9L2r8APcYBEaO4bZVDqKdGoFcsCaauiyvEBUlH4yTDDWD8BwJJXYoqto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39830400003)(346002)(396003)(376002)(451199021)(53546011)(26005)(83380400001)(38100700002)(41300700001)(2616005)(31686004)(186003)(66899021)(478600001)(42186006)(54906003)(66574015)(44832011)(7416002)(4326008)(6916009)(66476007)(66556008)(66946007)(316002)(5660300002)(36756003)(86362001)(31696002)(15974865002)(2906002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGcvYnFnYlRFT0d3MEZ4V29XRWgwaEs0MUdCYWJZN2wzQ1JCNmwyY3ZtMXBh?=
 =?utf-8?B?SXBpaE8yNnBQRXQvaHZPRmxKRmVsWDFPSjAydGZrUlhwaUtlRmtEYXZCV2ln?=
 =?utf-8?B?ak9BcU5ZMzNIaUlEOUZUWjBlS0dRZnp4VkV0VEFLd05QdGZUb3lUN2FCbGl0?=
 =?utf-8?B?NkJNRXlscXZMVUQrQ0xqOWhhdXpoT3lIVkhvZUhwbEU4SmJFTTA2L092eXph?=
 =?utf-8?B?T1kzdmFXMTQ4clpSeGEvSU5rREFRZHRRYkZWVmFxTXR6NkhQT1RJTlNROUgz?=
 =?utf-8?B?Q0ZEa0poUjRmZGl3RHppSDliSmFqeW9JcklWTUFlSDNFVU12c0J2eWdzY2tV?=
 =?utf-8?B?SXFYVFV5ZTNYZXMvWERUK3AybmM2ZTVkUmZEUTM3VklCVFdRQXdnNGFpVHRU?=
 =?utf-8?B?Ti9tZVUvbXQ0N1JVbzdWdHlTdHlmY0hSR2hwZTZCZld4R3NjbXhGNThGY1J5?=
 =?utf-8?B?dmlTWUUycTROYWRKcFBZQVJSUFBIakxxK3VsaEhOMm1ESFB0NzBpYk52d1Bt?=
 =?utf-8?B?WFMwamhLQWNndnBBc01aalBoeUZ1dERRdytRb2RzQyt3RnhSeXBRZUhoVkFZ?=
 =?utf-8?B?RkF4bm53K2pKcnpqTU5GUHRDVTZMeDJLM3laNUI4THk3SlBZTEdXWldEQ09j?=
 =?utf-8?B?cXZtZUhndGZDNlBSbXJlWlhwMDdMZlpKMGV5dDB4QXRtbENzbWN0aGpleEkz?=
 =?utf-8?B?NW5OVFN6L2E1bnlDQUxsK09mL0hqZzhLaVhrVk43NnJkb0x2eWo4OENnVTRh?=
 =?utf-8?B?dVRkOGdEWWpHRXNURHg0cHVlUllDZ0JPVkFQSUF1MS9qMkVRM1doTW15VlZ4?=
 =?utf-8?B?TlZKWktSN0h1Z3hoUGxWNlJqTnU0bkEvZ29jTFZPRGlaeUNQM05aRWpSNStM?=
 =?utf-8?B?dUkzc2EzYUhLZ084aUtkaTE1M0pzRU9oaXBxQ29wbUJzR245WnNobVIralVU?=
 =?utf-8?B?OVlERGVWOXFBdU9zWVovNjJPN2JFQTdkVFJHUDBvMldWRW5hT3NEYk13UXFP?=
 =?utf-8?B?UTVjUXdaZExqcHpCbERJbWRONk41d1pKY1lCVmNVM0VVMHR6bmVEb3hka3VE?=
 =?utf-8?B?VTFsWjNVN3IrL3B3TzRlc0lCSFZCMHhtMDJXNHJhTkhxeERSc1I5NFhnZ3pY?=
 =?utf-8?B?ZERuS0pFVXpIZXpmckQ0dHRWa1N5NmRvV2hUK0tRdytvVUpGTFRmRW1HcStE?=
 =?utf-8?B?U0wwSFMvWU5rSnEzYjk0TElGYmlzZVRWQmJTa0xhT0lwU0FjYUlaVnhDUXJi?=
 =?utf-8?B?K3ZTQ1pCTFFTN2k1dUp4bjJuM3dGQWdKWlpHaWsrUnRpTWQ4Q25KR2RGampp?=
 =?utf-8?B?MWRzVVNyblhtb1hqK0tWa2lsWm9FL1lDL25FRUJGcHl4VzRnVnVkWm9QYU0v?=
 =?utf-8?B?S1VUVUdhMDNQYkoydjV0eXI4N1RrSkxWN1Izb0RLSy9IT0krb1NaL2ZUcGll?=
 =?utf-8?B?MndsT2xCb2c5WWtDRnI2U01jWDlRa3R2OTZCc3pWaXpZSU5kd1BCV2xjc29J?=
 =?utf-8?B?THJVdTFzM0s3a1gwaFZhVkphZ1BFUzJFbGI3d2FsVDlDYnphRHpWZVZ2M1Nj?=
 =?utf-8?B?dWFJTnZGMlZpM1RtK3AwcmVUY2lOZkY0ZU92anV5dmF4aGpLU09kYm5XRjNv?=
 =?utf-8?B?QlZqSW9Jb0x0V3VEL1IvSGl5OWtDL1dJbkdmWE1obWZmVENZbUtDcU5GUFpu?=
 =?utf-8?B?TlZrdDVMOG8vZ1B5M2U5R1MwT3M0UTZkRkJsZ2pjQWZaN0NKcUNBb0NpMWFK?=
 =?utf-8?B?Q1N1ZmJTbDJ1b21JWURmc0xSbkVrZHU3WGg0Sm53MlJhUHpLUFYzak9keElm?=
 =?utf-8?B?dDBRRGpXQVhpQ1R2dzZOVVFMZDBZTTUrRjRsclJDKzY4NDF4N3pJTSthMTJH?=
 =?utf-8?B?TUxyREQyc25tQ3JGdUFXcWRkWTFBa1M3Z29lRTQveGdaYTF2SGFPQ2lxb1BB?=
 =?utf-8?B?c2l1OXBwa1RaVWp0TnVrYmU4cjNzcEIwc3NaeHBodmpkRi9NLzhPdm1sbm1N?=
 =?utf-8?B?emVDVkl5RXZ2VEt4Z05DSzZ3eW9WZ09vV3RvaDhYcDBJbUJlVlIxeEowWFBC?=
 =?utf-8?B?V2RCNHdESjRWYU55RjhhUm5VWCtESURBdzZBZ3ZhbU9CaUNiRy9XR21CREFH?=
 =?utf-8?Q?LQmQajHDySfVyu49Y9tQcEVfp?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52226068-ce15-4176-f3f3-08db47be43d8
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:57:51.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCR7RMbHHeAIsfS/ZmA6W/hSUMG4oKe+PlVsNQFaX6KOeGSV5cKbZnyI4DBxaD+hIPj4jRxTCflvUufOoYtScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1688
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.006
X-TMASE-Result: 10--37.219200-4.000000
X-TMASE-MatchedRID: yebcs53SkkD/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdlEv6AItKWF0ex
	crp35mDBWxjOUDkI5yCqW4fU4IlE4xzrJSe8bfGqTipLDaMylH0Ex2nnXvzNI0S0FpbI+14TCg4
	+Ouv0RSNV7gosQ1S3r8QXghxVFCP6qwoHAABsrQjwgrvJFY9E0YSkFXHm1a8tw62uSG5kL1b819
	1lvAtzOVSZHlAHrcAQ5YAvdCWT1bBJsyjYmmAr9I61Z+HJnvsOHA5wH3/21xHQv3GMCZUaFuc2M
	U6CoC3kT+8v17QjdI32BVCy1JdixTWs2YGWPbxrOIQ9GP2P2u9PnKxAOPp4WUty8cifGH0UGzEl
	PJ3tb7zY3iIlWCEIE1fgsRf3Qcdcgrm7ABCnURcF7cpFXK76TS3zVP69qL9nOmcd2FDUExsbpyW
	dc/Bd+X4Mw1s8WlGB79OsZb/ImRZ72OvVd+sqHhSceev8ZtpPjlRp8uau9oZuhQbABd4QQ76gCa
	8feq9dAd0cn1fMeA4AdHZZZOB38Vi4F1ScQrWQARprIm1hk20XjfR3d0weRoRRGq94HkP9SzCB6
	PyBOYFaYFHxXDqlaLsoYtanTEdis9gvQBjr0DQ6HG6H9FokceimxgRHwEwm7VbY2FZ8vgYVme4P
	LNz+/EOZ/T6VMD86CJdZSEEpzSjpPUecYo4HGvSG/+sPtZVkkdxcTYk4Um0XYnaoL/fgO5AjzBs
	6pqF7SpAFNe4DUJ4LEofWrUZHMF8+dSqKgz8/dhkilCSjv7UNW4va9iqt3pC/BCs92qoiMVdfMs
	aGcAtjvTA71MypWv/EMEB+Cg47qJIiwhbq5S+eAiCmPx4NwFkMvWAuahr8+gD2vYtOFhgqtq5d3
	cxkNQP90fJP9eHt
X-TMASE-XGENCLOUD: NULL-NULL-5-0-1
X-TM-Deliver-Signature: B198696500B4C7D72ABEF726228452A1
X-TM-Addin-Auth: M401r4OqL8XY5HcY4Xu1ncsC1v3Zy83Aa/tKDT3n8jwWOZ5rhaoZm0ATM69
	5uOHIs7f59dMBt6f6kXGxDO/pZB8tvxksHwcyDmm6XvUnl2IowqDNWgQZHcKnEIOME0f6ZAxJl9
	loRsn/OaAskTgKZitwQUJs/zEyMRcfkokqw+zHBfmsk4obOjcruuc7YoGMom4Wi7P/ndvG+tAsV
	WgOvLMufPQa986EASN4N2G2PYk9+h9tjCOzJWObtDFyIOI3S62ZuGnUkrmbGVPuLosnvDIqZ2tP
	dlBXcikaRPmeTtU=.nuv47dPfHy0GrgOrc1o4TxtRc4FLWKmGlWFimgX9Y7jCBXxwRtm5m9dhe2
	vuC1v7p3M5yrD200KWPVUqQUOP24kNQDuLtCjwI+Z/yGPAMJdo/7bG6j03QDtwmFpDSdd25gR2W
	wXpnYyUx8t6kmI0lRxdq9gft+ZqIMAU/giqn8C7KYsq9tfgpFVQ1zDWfvw/AQRLYU1Wct3MW3BT
	ZBcDXokYQAxoK4w9oqFrveggudwNsT1DU8p/wl57lesBtzBuKQ9ddi4SzByh/TFddkLPHM5WEvR
	TUZLR3Ct0Gcc4VjymSMeyFiVNzqT7sDF+Lr0lnZYmLUTC9ZGFfNMX7rVJ4g==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 28.04.23 05:22, Alexandre Courbot wrote:
> On Thu, Apr 27, 2023 at 11:35=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 27.04.23 12:13, Bart=C5=82omiej Grzesik wrote:
>>> Hi Alexander
>>>
>>> On Wed, Apr 26, 2023 at 6:00=E2=80=AFPM Alexander Gordeev
>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>> Hi Bart=C5=82omiej,
>>>>
>>>> On 21.04.23 13:49, Bart=C5=82omiej Grzesik wrote:
>>>>> +CC chromeos-arc-video-eng team that also works on virtio-video
>>>>>
>>>>> Hi everyone!
>>>>>
>>>>>    From the experience of working on virtio-video I can definitely ag=
ree
>>>>> with Alex Courbot, that moving to virtio-v4l2 will be a great move.
>>>>> This move will not only simply things a lot but also allow us things =
like
>>>>> vhost-net like implementation for some devices (however this is
>>>>> thinking way ahead and linux only).
>>>>>
>>>>> One added benefit of this move that I'd like to point out now, that
>>>>> probably
>>>>> haven't been mentioned before, is moving to asynchronous resource que=
ue
>>>>> call. Previously `VIRTIO_VIDEO_CMD_RESOURCE_QUEUE` have been
>>>>> synchronous and caused one hard to debug bug caused by this flawed
>>>>> design. During the command execution the virtio queue descriptors are
>>>>> blocked, potentially leading to dead locking the device. The implemen=
tation
>>>>> of virtio-v4l2 (even as is - btw nice work Alex!) eliminates this iss=
ue
>>>>> by moving to asynchronous response of the resource queue (VIDIOC_QBUF=
).
>>>>
>>>> Thanks for your valuable feedback! Could you please share some details
>>>> about the bug? That would be very helpful. I'm working on the next
>>>> version of the virtio-video draft, so I can change it there. I like th=
e
>>>> idea to use V4L2 as a reference, so we should probably do it like it i=
s
>>>> done there, only simpler. Still it would be interesting to know the
>>>> details, because we didn't have issues with the current design.
>>>
>>> In this bug, an app preallocated and enqueued all output buffers (to
>>> CAPTURE queue). This is inline with V4L2 and in case of virtualized vid=
eo
>>> stack helps with latency. Those enqueued buffers are holding virtqueue
>>> descriptors until filled with a decoded frame. While for one stream it =
is not an
>>> issue, but for more simultaneous streams, it quickly becomes a serious
>>> problem. In our case all descriptors from the virtqueue were consumed
>>> by enqueued output buffers and no other command could be issued
>>> to hypervisor. This dead locked the entire driver, by starving the driv=
er with
>>> descriptors - even STREAM_DESTROY command could not be issued and
>>> only solution was to reboot the guest.
>>>
>>> While it is easily solvable by adjusting the size of the virtqueue, it
>>> is a flaw to
>>> this design. The number would always have to a function of maximum numb=
er
>>> of supported streams - raising rather quickly.
>>>
>>> I remember having a few thoughts on how it could be solved and I think =
that
>>> removing the need to block those descriptors is the best approach in my=
 opinion.
>>> One would argue that preallocating descriptors for this purpose or spli=
tting
>>> the command queue to input, output and control might be a viable soluti=
on
>>> or per stream. However it would only delay the issue in time or could
>>> cause other streams to "starve".
>>
>> Thank you for the detailed description. This makes total sense to me
>> indeed. I thought about this problem some time and discussed it with my
>> colleagues. Indeed looks like it would be best to stop blocking these
>> descriptors. We can add more queues, but this doesn't look scalable
>> indeed. There are several ways to unblock the descriptors, I think.
>> First, we can do the same thing as in V4L2: add a separate (blocking?)
>> DEQUEUE command. But then we theoretically can have the same problem
>> with DRAIN, because it also blocks. So why not just use the event queue
>> to receive the completion events for both QUEUE and DRAIN commands
>> asynchronously? One could argue, that the errors should maybe come out
>> of band. But at the same time we already use event queue to deliver
>> dynamic resolution change events, that clearly should be delivered with
>> the flow of buffers.
>
> FWIW that's exactly how virtio-v4l2 handles things.

I'm not sure you read my email to the end.
I'm proposing a different thing. We already have an event queue. It is
used even for something, that should actually go with the flow of output
buffers: dynamic resolution change events. So we can simply add a
BUFFER_DEQUEUED events instead of doing the same thing in the command
queue by implementing a blocking DEQUEUE command as it is done in V4L2.
I think this is even better. This way we have blocked descriptors only
on the event queue, and this should never be a problem. Also this way we
automatically have correct ordering of DEQUEUE and DRC. Add a DRAIN
completion event here, and the whole thing becomes even better. It also
has to be synchronized to the flow of buffers. This way we don't have to
block on DRAIN or have to dequeue empty buffers with an EOS flag. The
whole thing becomes simpler and more consistent. Right?

--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

