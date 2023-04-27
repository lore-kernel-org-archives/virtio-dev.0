Return-Path: <virtio-dev-return-12450-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B433C77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:10:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B99FF2AD53
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:10:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D2A698664A
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:10:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5542D986642; Thu, 27 Apr 2023 14:10:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 434CF986644
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 14:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682604651.757000
X-TM-MAIL-UUID: d1c84556-44ed-40d9-9f4b-596b11fadf82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6sL/Ku2BKvnNmb0YaFJMYjwRENS0F4cgMo8rfTf37yX/lQA/SZU3T2He+O5TC+lqy4t9ZQn+iJ5STKBUqgHyEhluTdHvAU7pHqXz/gNkvDH3FbNgroqhSwUKDyLAoJo/PZUjGub/rDYPgrxDdScx4K/MgLXbaWxW+Y1rugnLGVMzkRtWI8FkOh4AYnnNsK3KxA+qCoWPhCMcNC6CHV1616oUB7zJkqmMBKPs0vwnZBiUID1Xsw1Kev6U3XnDl1tk4UxKiUEWSp4AaqgeXXULoD/Xs03W/uZV04thverqt4hxHVhKd8hyJ8/lxnpq8FB7eda07TTmjybCHNnHi9J2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSh7b/9vv8gAjQ5ZSA3e2pIS1RS22TFoJkmIrIg5+VU=;
 b=nFFZyr5Aisz5Bt6lUYTRuupi6h64vPkgrnVouwy7E3dk6CthqxvhBzHuce9MLqN+maw8jw2TDW3vdyqEhYeWLcoK/7pcTnlJmRcSIBONxTsmF+v6B8m6KCn1fwcMRE4jOQmNk8/y35KkeARzXUqMVvd2AHzBp3URlyckD1lu21xLEnVXkAlJ70RJUjf0+V8FCjykvQBBTpJpVVlBWM7Gd0F+G00zQ+DVGlH1F3rEUmnfJi9sqaUiRJ1cRqGkzFXrGxAiWvnmt6c02BQgFcoRAm1opMRlU4CtPXlTIgafQB40Myvfs7E+tClanq4qi93OawuzQwIfi6WV1R1j3+Gulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <c1658889-0a90-5681-6afb-7160cdf1bf77@opensynergy.com>
Date: Thu, 27 Apr 2023 16:10:47 +0200
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>,
 =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
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
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
 <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <87354okkx5.fsf@redhat.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87354okkx5.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::40) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BEZP281MB3108:EE_
X-MS-Office365-Filtering-Correlation-Id: 74210945-7a30-44d4-d9c9-08db47293419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rLcyd4yPsV7M3KkfIRp06ei3hwGEuYL4q72tAn3WCCQB1bwBTh4N9p2pkgCV2/hH9WZXadgqR78nsEvt+CZecG8o6f33jz9X25wJOgOWdR+YqsRxl/dAmtJX6Qb3vD2aNBUFbYsH+dnIhkwsIxEDBW99UcfZmz1LZw55Sd8NyQW9hzHCrQOPruPhtdacV7pa7sf8PBYYlWF/b+Sk1jT64ecq17cUNE8YN8gzVqp4GMX34Oa4t05zNCGemzXTx2gxWpMgrTiYfrvSdag+YyXPkBVZMogM8DUU+S4zf0HwcxzIpPG8432m/PM/0hVpEN69EgcKumM7zCz/k52lKdC3dFKG0zASg8c9qWGtQtGjXhTy1nXJ7N1YHcqwyWbOdEO4XRizzreIu4VmmALDFYZ4At0kYcq5yWEeHQELXU6D4JW+9TAIja3OFaoCvjgfozYV/Y1KzVd2KeF66ixEOPVInTLTEYKbpNvu0w2JbmwUJRshkOjvw3z4Ss9L3egq7k9XH++InEB/ovNPDQRb/cLoP9o2A4lLPXA/3sK1AOCtObc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39840400004)(136003)(366004)(451199021)(31686004)(66899021)(26005)(38100700002)(66476007)(31696002)(4326008)(41300700001)(15974865002)(66556008)(66946007)(86362001)(478600001)(54906003)(42186006)(36756003)(316002)(110136005)(66574015)(83380400001)(2616005)(53546011)(186003)(8936002)(5660300002)(8676002)(2906002)(7416002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXd1TVRGQjdYTVlZOHA5SjNmWFBmT3NsNWlXcG8zb09JeEp1VVU1ZnlGSVVO?=
 =?utf-8?B?dnFUUGlSOTJXMzRtMld0cEZYMHlkNDlQbjhLd0dDd1NUclpWRk9YSGhvV0NQ?=
 =?utf-8?B?RmU2eENaaHJ3TDRwQWNKaDVHNHppNFRoYjFGdjlvTTZMQnBjTWpINUw3NXFz?=
 =?utf-8?B?Y0txQUx6TW02Y29TVVdYd2V2a21CTUwzU3JISERocWpBSDR3LzIrSzJqUTM4?=
 =?utf-8?B?ZlJrZUUzUkVLYkN1bCsyZEluZmIwTFVoVmNES1ZTV2tScTJhNDhia1A3alVk?=
 =?utf-8?B?VkFYMkZDR01jNkRoZk1lNUJ0U2RxbXdBa0V3ZDdQMThuZkloWWJFbERKSGpW?=
 =?utf-8?B?T0syUU05ZU0vN2hYUGtOc1JlTXUxcy9aNDVuV0JhUWlSSWtqZGJHMTdJY0ZC?=
 =?utf-8?B?bnlYcDNrVkhBSEs2UkZzTzlScHpLSVBZdnltOTJQQ2xVL1FiV0lEMCtma1Rs?=
 =?utf-8?B?bGYrNklVeGlQWHMxOHpNMGRSRUFJbllsd3luTUtpVnpuS2ZVUmxIdDVRQUp6?=
 =?utf-8?B?YU1peW9EenRuMlB4aUFnSTl0ajhmWFRDTFVKcGo2ZmdKRHhPNExFUU01Z1pq?=
 =?utf-8?B?c1NSdG1UUGFPKzJUaUcwd0N6UkJOaEp0M0wyMTVsUXBuc3BHY0Nrc1N0RmZt?=
 =?utf-8?B?c3NGUkJKV3gvNjNIMFNVTGdVV1hGbjB3RkZVVGIwYTlXdXVJS2s1Uk5DanVt?=
 =?utf-8?B?UW8rYnJYWDBvTWp2dGdqMGdRcHd4ektzZDlzZ0VjbFlucEVQQ1duMkxXRm9h?=
 =?utf-8?B?SGlMaUZmUkhHRWU5Tk9NbEU1WERrY3Bab2E3UUg1bDVMbVJsTyszRkEzdWsy?=
 =?utf-8?B?VjlVeFdDbDFwRC9PYmcxVWk4ZmRBQUdrT2tNNnJRQXc5TzVLbXliQkNFWmRS?=
 =?utf-8?B?YmRKNXMxR0oxbzJ0c0dRT2p2R0ZLWnZhV1lvNjV0alQvN21ubzIwOVh2c2Iv?=
 =?utf-8?B?N2VSSFNZZ3BYLzlyL0VTSzk1MFI0ak1wVFJYZUlZL2I4OWJjSWhhd25HUmln?=
 =?utf-8?B?NWh4a013bUl5aVAzMklQZXFySmlsb3VqZ0lHVm1DVDlEOXpaMUs5R1dweFdt?=
 =?utf-8?B?ZytrSGRBOUlWNWZwektTQlZMd3pzMzMxL2F5NTZlUTZuYnVweklWRHZOSlB5?=
 =?utf-8?B?bWZUNThOSld5cTRKdHdZbk12cXd2bGorK0FlWEJoMU82bXZKZUpraUxVNHp0?=
 =?utf-8?B?UXUzVHZuYWNoUnNLamZkS2hyMjNyYUZGUEJvZTFCZWhITlhwT0I0bUFJZnht?=
 =?utf-8?B?R1huQzlaRzc3NXNNa2tQK0RMelZsZEY5QjhWMXJKWUoyZE1jVUg5NXlGRDh5?=
 =?utf-8?B?VENEUlRCTHE5ZWF4NEdXQWR4alI0Mzh0YjY2QUZkamtQbjdJcGZPdkp3R3J2?=
 =?utf-8?B?RTNGMEF3SlhzN2pRMmJNNnRad3RRRXhDT1V5WXY4SDhweTJqWGpPU3JUOWxF?=
 =?utf-8?B?anR0M1BWZU1FY3U0TE9NWmdiSkh6RlRIMi9NNi81VjBWL2oya1V3VlJJL0tR?=
 =?utf-8?B?Qld3bDZVcmorUFc3Q08xY2VsdGVHSlE5L01zcGROR0hadmIrcnNOV1gwemdH?=
 =?utf-8?B?Nnd0UlFNVlV2ZmZvalYrVlJUblkrNHlUT25zb0xRclE2ZytVRFVxaVEzWnY3?=
 =?utf-8?B?Z2dOaWl0YlZ6dGswdzE4Z2xFbGo3YmdVZERCUXVLejRjWjVUamkwd1NyYjVS?=
 =?utf-8?B?T25lUVI4YW9aeitmNExuWkR5OHRJcVpNbFZTWGEvNUNEVUJFQUwwM3VSVjh5?=
 =?utf-8?B?S1lYQWRYaCtjTmNyMzIyWFFQVEc5dFd5WmJ5OHdvNHNxTm0xUENhRkt6QWpE?=
 =?utf-8?B?eU5Ba2ZHdjRZa2ZkcEFQMWI4Y1NJS0N5bmRNRHo4OEpiaGJnTncxeTVubjhY?=
 =?utf-8?B?bENNSE1US243RTdlVFlDZmM2NnZCVzhnUzVFVGtpZUxTOU5tMFY2U2ptWEZn?=
 =?utf-8?B?bVppQ1ByeG5oYm1XTWdLQkVIOHM3M0JmbURDaWZlaVRreDBuenlKcGhpMWlM?=
 =?utf-8?B?eUFuSVBLd1JhamNHRHl6Qkk1dDN4QXlWTVVGbWlmNGgyTWVDTzVkb29BZzl2?=
 =?utf-8?B?NWhkTDBBSVZCS1NsSDk5SzI1Nm1ycDZpclVISzdHN05oSTg3RFlOVUFXZlND?=
 =?utf-8?Q?rdQKK4Zy4MqVyRXRxttkIfvwa?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74210945-7a30-44d4-d9c9-08db47293419
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:10:49.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mt//fLC8KTOsS5E6Gyk+gCUi31FhwyYoW8KYmc27T3hr/KTwEJfuVtILRqoE6C4CIn5RY5UaFW6xbFaL8+gnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3108
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.000
X-TMASE-Result: 10--28.837500-4.000000
X-TMASE-MatchedRID: CxmI61mtwh//9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdRXC4cX65cJG4F
	lM3eSv+GyuwPhdMTt8cYHz3lIGfv9tF2D+Q2NCgishZoVNAELFNRMEg8Dnr1ISIqpZjtBYB7r9u
	RJkJ4WbcGddFSAB0+4rMTUjboGcLo36XbR6azseNZNYSHk3Zr0dG3Y6ijqBt3RZrOmBLNtw/d5v
	bacDwdd3NIElf2cEvaw+/GhazHhGLXwvfllQQSgbPx3rO+jk2Q6y37p6CPIsDfUZT83lbkEIpSZ
	pRfKeEHqlPqyPnNc5HugYf75qB+Mu407XMquNtmrdLFFKR7dulNLPQl0QAltNbZhgeyVPQjt3Am
	Tg6pdxb2324nCPCVUZXBiw7NP4CJhFhuH8Sj5cVDk5poSYXNlzoSfZud5+GgzBnz0ZuJSWc3KV6
	TwldBNzsxn9LKds/KRL/JBgHPRCqSvyayL9CyLjiEPRj9j9rvXKVjo8xZtT6gY3nWB9vQ8IA3MR
	TuVD1MD4Vs6/oyaPL+5zqF/U5PvCD4cUUPKOZ3g9XZqJGXaHFqwd/sYtbRQMy2i0a2kXlWPzyfK
	fkc7AHvPBXLPdbeHNPqUfhGuXCC7pTlG5Lbu4xhrfDkhK+Q/xyzHcgfiyrcgERCUWHwg4ds3SaN
	vMeHp7VETMvJoI/qMH5cHrvff8zRTAZ5iUYfyYdlc1JaOB1TNZEftOVQtYbcJp3M4rP5Po1EI8A
	Wiw6UVWYogWl8xmlehbG5gR/GLwNhs+ry1L3s+s0+QZYAcN+hCEsahX9YEqzswz3t7qTh4J21g7
	IBeX27eaK9qrX3Gkc+YfLo55UjbSuhC0WauSx+yskgwrfsC30tCKdnhB581B0Hk1Q1KyLUZxEAl
	FPo8/cUt5lc1lLgkU6UkIr/V+1nME/Jsn/m+g==
X-TMASE-XGENCLOUD: 2a6b7135-2bf0-41a2-86f3-2eac8abe3090-0-0-200-0
X-TM-Deliver-Signature: 0B3A53A8D519F6D39C01E9EBEF1D4342
X-TM-Addin-Auth: sy78e/y23l1s1Co/262HRWXOxqutw49wOpYpdAPWznBgEr+jJ7VWtn2WS+d
	phrO1IpRoMmRInv4S4M+q+LeF/G3ttJ138jHB3PmQzZkOLhDB7SinTC7JSxALXhgPxIlRWDMZwN
	x7Oryw8WMfFrdicZOnJLFMDGILpTcZMku7YnAYPDqm7YklgqV3TLsa8/SyrxZoMWjYURsUWW3+K
	JyNd5dyTst0ymOzh2tP72l2inXeIBaZ+EQqyv0b5nwpIPik6RCcXhqQVAY7czfxhPGCPaVIQ9IX
	FVpXyGIVy9eRhFE=.ujynVIkWqKo3CV3jhOTlsJGlfYbrtSikpGKgGTSMuf2wjQx0I8AxWDq9wk
	TsqaZw9Vq9+k0D2Le72YNns0RZIeH285sNW4dGgZiRNh9ed+UFyKEZgs/mv1lquVbN0x2Yy3TgI
	bsNIPCTBxnvCRfMftvidoMwOCnBbaaMWt+LpPbygjQ0Gg2yu7uZ4NGOpvV6NxExX897HV4SUmBz
	V0NWDvC47wXZtoyoHvX6873ukubluui3PvQCkeL4lOgKMdP9C3VbMp0aw5dED8kwx024miHucHa
	yeuOyywbuX8gyeb9Wbal4FCrhfZZ1Oe3Gf48fxqlXlzC4ZdniOt1/+UrKSA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 25.04.23 18:04, Cornelia Huck wrote:
>
> [I'm replying here, as that seems to be the last message in the thread,
> and my reply hopefully catches everyone interested here.]
>
> To do a very high level summary, we have (at least) two use cases for
> virtio-video, that unfortunately have quite different requirements. Both
> want to encode/decode video, but in different environments.
>
> - The "restricted" case: Priority is on security, and the attack surface
>    should be kept as small as possible, for example, by avoiding unneded
>    complexity in the interface. Fancy allocations and management should
>    be avoided. The required functionality is also quite clearly defined.
> - The "feature-rich" case: Priority is on enabling features, and being
>    able to re-use existing V4L2 support is considered a big plus. Both
>    device and driver implementations will be implemented in a full OS
>    environment, so all kind of helpers are already available.
>
> (This is not to say that one case does not care about functionality or
> security; it's mostly a case of different priorities and environments.)

I'm thinking about the latter as more like a "compatibility" case, but
the "feature-rich" is also a good name.

> I had been hoping that it would be possible to find kind of a common
> ground between the two cases, but reading the thread, I'm not quite as
> hopeful anymore... if we really don't manage to find an approach to make
> the different requirements co-exist, a separate virtio-v4l2 device might
> be the way to go -- but I've not totally given up hope yet.

 From our side I can say, that moving from the current state even to a
well-defined subset of V4L2 would require a lot of work, bring literally
zero advantages for our use-case, while bringing some disadvantages. I
think we had a good progress so far, we don't want to give up the
achievements and now this is a great opportunity to do even better
because our priorities will not collide anymore.

On the other side I don't think Alexandre and his team are really
interested in doing the extra work of clearly defining the subset of
V4L2, writing larger specifications, going through all the hassle with
making the guest pages sharing work (again) and supporting this case in
their driver for us for something that is planned to be a very simple
device and driver. Please correct me if I'm wrong here.

And even if they say they agree to do the work with us... I'm sorry, but
you can probably see, that our communication doesn't go smooth. My
emails are forgotten, our use-case is clearly not a priority for
Alexandre, my arguments seem to be considered as obstacles. If we have a
single device, we have to cooperate actively. I have a lot of doubts
that it is possible at the moment. In this case I'd prefer to just make
room for everybody. Maybe we'll cooperate in a fruitful way again later.
The priorities or use-cases might change, for example. For us this is an
opportunity to finally update the virtio-video driver against the latest
state and hopefully make it V4L2 compliant.

> Some remarks from my side:
>
> - I'm not totally convinced that counting words is always a good proxy
>    for complexity -- an interface might be simple on paper, but if the
>    actual implementation would need to be quite involved to get it right,
>    we'd again have a lot of opportunity for mistakes.

Well, I agree, that this is not the best possible benchmark. At least it
is simple. My idea was that our output as spec writers is words. I hope
at some point we'll have a better benchmark or just agree, that these
structures have a lot of completely irrelevant stuff and it is not
immediately clear, what is necessary and what is not. Maybe the number
of different definitions (structs, struct fields, enum members, defines,
etc) would be a better benchmark?

> - How much of v4l2 does actually need to be in the device specification
>    for a driver to make potentially good use of it? Sure, being able to
>    directly map to v4l2 really gives a huge benefit, but is there a way
>    to extract a subset that's not too complex, but can be easily wrapped
>    for interfacing with v4l2? (Both interface and functionality wise.)
>    Even if that means that a driver would need to implement some kind of
>    shim, a layer that easily maps to v4l2 concepts would still be much
>    easier to implement than one that needs to map two quite different
>    interfaces. [I'm really relying on the good judgement of people
>    familiar with the interfaces here :)]

I don't have an answer at the moment unfortunately.

> - To which extent does security need to be baked into the device
>    specification? We should avoid footguns, and avoiding needless
>    complication is also a good idea, but while every new functionality
>    means more attack surface, it also enables more use cases. That
>    tension is hard to resolve; how much of it can we alleviate by making
>    things optional?

My opinion is that it is best to not compromise on security right from
the start and not give up what we already have. Because it is hard to
add it back later. It is best to define clear granular interfaces from
the beginning, use feature flags where possible and also have many
different devices. Then it is easy both to add features and to reduce
the attack surface by disabling them. No device, no problem. I think
V4L2 does too many things with no clear way of disabling various
features. Defining the stateful decoder and encoder interfaces is a
great thing. We can already benefit from this. But I can see, that this
work is not finished yet.

> I hope I have not muddied the waters here, but I'd really like to see an
> agreement on how to continue (with two different devices, if there is
> really no other way.)

Thanks for your suggestions!

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

