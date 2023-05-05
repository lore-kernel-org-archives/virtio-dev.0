Return-Path: <virtio-dev-return-12570-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339A1C7EE22
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 09:57:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4800714568E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 09:57:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2528A9866BE
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 09:57:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 02D2898653E; Fri,  5 May 2023 09:57:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3E3098665C
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 09:57:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1683280655.259000
X-TM-MAIL-UUID: 253818fa-81a1-4b53-81ac-78ef988b1504
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihBNJkaS8YeUDxzdGUFgsfkcTKod1RPvJohDt7i6pCm0fwrWgHcJAmfzs4OxnIUZ6kDuVDmBklc+7xLJdU7SHNLrteBt97zZUxlzpmlYHc5XDWdMkviKnyRtJ2/rq8SCvd67wT3Faa3zM3R7jwG4OaF4boy4oWzdWPJg4Hm+Dov9ghEhRgH3e5zO4KA7XPoPEWhU1LKgDsWyBypAx2FqJq4MWaGZOqMkvLQq9sNpYKE/pEvRLRxDXdwej3wV6bCIrwsdv9/KVyuMJRSNbVoJEYvjt5+m0jx5KHsZylNHsIaJvbeYz5tY2pbe4mY2F/mFIOunRP3JcYAGsFyYU4a0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncsYfDA85oBWvXRsflHlIBxff7axBeP9Y8rHxy8PzWk=;
 b=lOozbwoloKjdpGNRIslfoLhXjCNzdv4mERkCFh9+DzEDv2+j16AAUdD2D/QLy0pe8FuAee/FDKbkUEskNpbCf2PnfSgP19zW9Kvj4Hw+S/BXeURsrtVbrNvvzEUIIRhP6YT1KRIwJHGumVN1by1WgkXYyxqIDVkBKHgWfGTMJPOQGRBVX1jLBYSN45+SFYvhxbnsUcygDQ3EqqBQciQQn45u5dX7Ts7NI6r3r0fR/ZDWtrzgcMLBv1+N4kBU2z+sdmc/RMhLdpMwAaBQVidaZc62QQpHz4+4rcU2oh9ThdyTFlSqbKvjdheeyCcDul9O22JkLRgNZOUxg/9VJLdEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a3607ef3-ffd9-345b-0191-5bc946f4be19@opensynergy.com>
Date: Fri, 5 May 2023 11:57:29 +0200
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
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
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com> <87354dtp30.fsf@linaro.org>
 <87bkj1h0nf.fsf@redhat.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87bkj1h0nf.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BEXP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::25)
 To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BEZP281MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7e3933-e9be-4f84-83db-08db4d4f254d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MzFChd+lELTtKj8p2aOHNBYlBLqABkpQBx6KzuTXoFlPOjAfmIL9Sxu9vMhoL+MsRKk+180uZFXRh38183bbAsmupcBF+QmK+o12DhF3+Q60C1zZtuy70/z6HbiyZj8+AUBYMuflxVxhfS9AZu5AiBs8+t+dlOdsl2aoaAQHlT8y0Bli5uegchV1dclVqk08T5kKa200ZsLBQSp3PSVBqxJD/0resMwgIRHeQwzSRcUfhAjZctArDPBOK+bs7ZwPdWREoHWMbJUi7Qc1+9scuKiTIwxIiSj8MtSL3ncfHlYjOZucYrpVZpCbv/XFlXmacBbSvo3mE63qsroQLJkRUBNw+sYNx5MuKM2j+6iQbw39JMEWwawLACOw6FEZbO3KvxWkvXaxo/p7jrihVpNnoesOAQImEhAxIlzY01arpmtId+wAKlfhRSsX3XbyAiOBq16cisou9wQBBjWI1uv5x5UcqdMADOEDKOjVm6gz07JD1L7AaZloKwVrDHXlPdTS07ZSI0Obg+AGsbb1EFqDjD2/Lb0bW7jFjwc1CrQGw7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39840400004)(366004)(451199021)(31696002)(15974865002)(36756003)(86362001)(110136005)(316002)(54906003)(42186006)(66556008)(4326008)(66476007)(66946007)(478600001)(41300700001)(5660300002)(8936002)(8676002)(2906002)(7416002)(44832011)(38100700002)(186003)(2616005)(53546011)(26005)(83380400001)(66574015)(66899021)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFFIZWt0K1E3TDMrR2w2TXRQWjBia0FHZWxIYTF0SzEvWnNlWFRPU2NGWXJ4?=
 =?utf-8?B?REtCcDZzcS9pMHpRKzM4NjgzRnRxZUpEWWUxcllobE1FTzdTVktPLy9yZ3pm?=
 =?utf-8?B?Q0lIM0tKZ08xTHVSWmg1SlVXK2psUVRNVDZHYXFRYzNPWHYxU0c2cTE3SkJK?=
 =?utf-8?B?VnhsMkJRdnRjanFMcXNiUnpVbktYbWFQaEVEdlQ3b0hnTC9Ka215c050UjFj?=
 =?utf-8?B?TmxQV0Y5YlF4M2srOTFjUlpqQnlteW5VRGtJUUhKN25BTjZobkE4RnBPVzJn?=
 =?utf-8?B?RTYwL0xLZ2F5NWlSK2ZyOTRCTnVNVUl4dS9Rdi9vbHE3UUdEVXJFdkNEVk5N?=
 =?utf-8?B?cEJpb0xjVWYxV0k2akFva3JxdUFKTkhlRHJYNVNOMitjY0J3WlNRMGVHTndE?=
 =?utf-8?B?TjNHendiN2lSVDd5di9VK2J2ZG1jTTNxcHRXSXk2d0tUTUZTWjB1SVc5TmZv?=
 =?utf-8?B?Q1E1bWtLZnZzYzhjOFJMWVkybGtTOWZDb0F3QmFrZkpzZml6OERRWmFnVlVG?=
 =?utf-8?B?SFBuTEExK0hPWEdQSVh5K2ZRSTNRTlg3Mmh0QmxkYThTVXVLL3MxT1c2a08x?=
 =?utf-8?B?VGpBRUZaZDRHNXFPM0RpazVmeHMzeWk2U1RkbmlyTlpCTGRwaFRncndaYUhM?=
 =?utf-8?B?MEdIZGhEYVFEMkt0Z2pLOEFTallWWGpZVkxSemlXMEZoN2JOc05HbEd0Qzln?=
 =?utf-8?B?c1NHREFnZ0kvcmpBdFdiai9tYXFYZ3I0R3M0NzVoaWE5QmdKN0JKVVpYeHpQ?=
 =?utf-8?B?SS8rL3owVUpPVDFlWlJKK05WcGZzWlF6cm5uWEcwaWl1b1hSY0RoMEpOVUo0?=
 =?utf-8?B?bU1yZXZxODVaTjZCR1BVUHpiVlpzYW8zbGVGOTdqak5GR2JYaSt5cjV6cG4v?=
 =?utf-8?B?eEgxcHZ2SjVUL2NPZEFkZ3dzSVJCSTJ3U3VrbFFVakZOaUY5NTlmS3NaTEtH?=
 =?utf-8?B?K3NjbXZ3NWV3NW5NK21TcjNYcklxQVJ2WkJJSmQrQlh4Tm12WGlGQjJZbEl0?=
 =?utf-8?B?SHlZVlBVYmQ0N2tPVGlTTzBDSDY4SldVUlRreVFlNDJBVWxmTjNOUHRvY3F1?=
 =?utf-8?B?OEZJWXJ0ZXRHMHdsMjNRS1JDMHJKbzZiQjRpc0RJc3VaREhtKzVlYTkrL0ZV?=
 =?utf-8?B?dklGTlJ4SjJac1lCTmxWUWFJRzV0ZU8wbVhIRUUwNHFUZGZkZ2grNzZaMDlP?=
 =?utf-8?B?R0d3RlFWZGdYWGhaUWFmWTBNS1dCWk5kUkcrNVBKbEIxN1JiY01idVVMUHdT?=
 =?utf-8?B?Mk9lalYrTXZVRGJjSTBBVXkrMWtCQWdlaHYrVG14YUU3QXRjTHdBQjlWRjh4?=
 =?utf-8?B?T2trVFB2RzRvVGFlSGtUVncydnpyVnNhMU5xNGkvNmJyOWRvZjNxZUJUcElM?=
 =?utf-8?B?QStMMVZjTGdFYUo2SWk5L0kzVDhzNk41RmRzUURYOXhKMEZHOEkveGRyMHZW?=
 =?utf-8?B?bjIzWEJPV0F0YVVsc2FMTGozTWRZZlMxVUZBejc1K3JpNURzTGVleXdCT21B?=
 =?utf-8?B?QVo4Ym9jZXpDaXh1N1RJbTExdXcvYkNCK0UzREQ5a2tZV2NucTJIaGhmcUd4?=
 =?utf-8?B?RmhjeGFkdHRJL3dhRWxyeUc2YzB3cW8wZ2ZTQXhLU1BGOHU5UzVWTUxBZVJN?=
 =?utf-8?B?Qnp0bWtTalNua2JMUGxUeTdUbHZ4bUVIOThFZFpLYmd2VzYvZU10enc0QzVO?=
 =?utf-8?B?aUJjMFNETkpURlVIWnZCSFFqNUV3dUpXenlZOTN0OGo1Rm9XU3hneWVlS3hi?=
 =?utf-8?B?dUE5OExLWTVKVmNKZlM4VmNPQVdPNUlKU1EvdTFIVU9EOFNaN2Z2KzVzdG9h?=
 =?utf-8?B?K2lvWXNySE42MGFVa3FnQUNBSUk3NXNTajFCWTNyMi9wM2hZTi9EYWlSNjBK?=
 =?utf-8?B?OVVqL1RMS3U4WVI5WEJ2RU50a25HaVVEdUQ2bTk2NjE4aGM1bkNTV3BURytI?=
 =?utf-8?B?amYweFFMZ1JYUjJKVjhidXMzQUkyb3BaaW5xS3hXL2xUVldtTVlQcXVIa0hv?=
 =?utf-8?B?YTQyV25tUEFvWklLNmJESVRPRTNpOCs2aE1KbGV1VFlmZlVyc3VjcC9iRzRN?=
 =?utf-8?B?dzB6YUJwZE15N01UT0w5VEpoU3p1aW9ZRENheXp2eVpNYUxRbTF3RDEyNGd5?=
 =?utf-8?Q?ExXe3g5HmwLCGs/qyPhUGMrEm?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7e3933-e9be-4f84-83db-08db4d4f254d
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:57:33.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MGryAszLn8ui8FK8E1Ugw5Jd6uB1pk4cGwKCMC7xiCuYC1qPXlWpIMB/XZ287vXS1EEGqDrjIM7J+7oAGmGvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2673
X-TM-AS-ERS: 104.47.11.173-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27606.006
X-TMASE-Result: 10--12.746400-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYJF5
	C17m8KTraz4PPTQqgvbniA36f6y3d2C5k6NopKxYi95/KnWCU3TB0/7xhd4ByQmCgV9N+g/6Pkq
	rm3IbK/OEutUZt/fyv6Sb7sFeOcmT+UviL1yO5g1W1k0wh4Tk8cnlJe2gk8vIA9gN3JKb5fc+oo
	FgP42TR47uFu0kSjHibvc/LnF/WDNOBjuTIREKLd5x7RpGJf1aSP0QtOWCqNi15eNIExiead211
	7Mk9wKfuUxcEq68iwOP1k7a4QkoKCWHswFw/yu93J386TUJ4bxTZ+NmI28jKQRQRC1CtNtnQ6VP
	vO9yH3GgPyPjoZEIzQ9IHBj7BCrLuR7APGv5+oi/x8sBfQ/nQGCDsc7zPa02//6LNRWr/sZn9Ac
	gA9qVXkWG0od6ar2i0SFdaft8A7oSgRbp/xnTpEzs4u81P77pajzNTFMlQCOwuKAMD8Wm9aHLmp
	r6pROgtsDkvuS4EQvvg4/ZnYTMlUcx6G5mx77OaDCzqDR7DPY9DpdZx5HaZS99T+uJIleR7FFhl
	jeLP1zMmbaec67Hcs+0upIYi1yJsSfa8QAGALoEOhHzDsL05pq7DiIZuJv44TQVKfJL+uYZGgGa
	H7R5LRliU1mWF9img+v5rI7p03YumHyO4Y/CAxHdIZ6edcbr0yxg8hRYM2nICMF8PHDOJdvSBpm
	BATJqgPIKS3wC+o6AByYFO0RfHAjt4l5TmF6fkiSxx29igC1OGffsUU/kDSiBW3vjFK0WIt0UIT
	1kcjymKbv8RSDxNs4Gi5oTMySUI0IWeDfSqUh+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+siOwBXM346/+wjDajUBxzbr3riX+JF/laE1O601kjOmDULMirEWXfmWbkC/tjB
	AZ+D
X-TMASE-XGENCLOUD: d620ab15-3d89-49ff-9272-a161d5975aa2-0-0-200-0
X-TM-Deliver-Signature: 6978BD7D95A0278C22D03A9291F6C1E1
X-TM-Addin-Auth: tU78/8rZjYkiB23FMjnzNAONWiRtwd//b8IPE6LhDHKjud3frkPBJ9zs3cF
	+WUWFbDWG+l4d/C754UQ5rhObAxP/xgjcP3En5V7+tv4hzk6mwf81MG19nxvi4kMXJ7lWn4I6Oh
	W+Icca3WwJCvsoEIHr4/Fdw2amoVUCpBW4zPG4CyvOVc5xpJ8IQDBvtojipeUNn2yPXJuumI41x
	/rdMqdIQ3gvjCxQy56cMD0L2x2krdNJzn/d+upKv73IeuMw2gWxX8BJV6sanuSnFHqwD8uU7bNV
	0IIiBO0VwzvBYeY=.jk7sDnc0U9/WE/cOXzxL6NhFF1fv+a8TN3FfW5/Zpmb1qbZ5IwdDNNN8r1
	DVq1F3npdcpQZOzmiV8EnaY+MrKegx22hNqNu4R3qpv/R8dASHUD8J99XkNgSN8XTfHi0yYGraC
	4Ul/keiVarTYyZ7+K5Lfo+abLJ2etFcnlgOX5HFY9D8dF/PQ7k3DnqZnviCthBU+e9Hns23yrz8
	e0fCpoNOuU6FIQAnSZvEkevgLnIXwUFR+3WK3KmjFVkqZ4pXFLiTleajx1EI4ufoiBOOX9RQYKe
	Ul/1Lk5nmrsp+jlrhgsOz7BMCbdc/E9lGJ+Dol7NFroFPhYPU5QiXkc+kKw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 03.05.23 17:53, Cornelia Huck wrote:
> On Wed, May 03 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Cornelia Huck <cohuck@redhat.com> writes:
>>
>>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.c=
om> wrote:
>>>
>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>>> But in any case, that's irrelevant to the guest-host interface, and I
>>>>> think a big part of the disagreement stems from the misconception tha=
t
>>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>>> which is absolutely not the case.
>>>>
>>>> I understand this, of course. I'm arguing, that it is harder to
>>>> implement it, get it straight and then maintain it over years. Also it
>>>> brings limitations, that sometimes can be workarounded in the virtio
>>>> spec, but this always comes at a cost of decreased readability and
>>>> increased complexity. Overall it looks clearly as a downgrade compared
>>>> to virtio-video for our use-case. And I believe it would be the same f=
or
>>>> every developer, that has to actually implement the spec, not just do
>>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>>> compatibility device (which I believe it is), then it is fine to have
>>>> both and keep improving the virtio-video, including taking the best
>>>> ideas from the V4L2 and overall using it as a reference to make writin=
g
>>>> the driver simpler.
>>>
>>> Let me jump in here and ask another question:
>>>
>>> Imagine that, some years in the future, somebody wants to add a virtio
>>> device for handling video encoding/decoding to their hypervisor.
>>>
>>> Option 1: There are different devices to chose from. How is the person
>>> implementing this supposed to pick a device? They might have a narrow
>>> use case, where it is clear which of the devices is the one that needs =
to
>>> be supported; but they also might have multiple, diverse use cases, and
>>> end up needing to implement all of the devices.
>>>
>>> Option 2: There is one device with various optional features. The perso=
n
>>> implementing this can start off with a certain subset of features
>>> depending on their expected use cases, and add to it later, if needed;
>>> but the upfront complexity might be too high for specialized use cases.
>>>
>>> Leaving concrete references to V4L2 out of the picture, we're currently
>>> trying to decide whether our future will be more like Option 1 or Optio=
n
>>> 2, with their respective trade-offs.
>>>
>>> I'm slightly biased towards Option 2; does it look feasible at all, or
>>> am I missing something essential here? (I had the impression that some
>>> previous confusion had been cleared up; apologies in advance if I'm
>>> misrepresenting things.)
>>>
>>> I'd really love to see some kind of consensus for 1.3, if at all
>>> possible :)
>>
>> I think feature discovery and extensibility is a key part of the VirtIO
>> paradigm which is why I find the virtio-v4l approach limiting. By
>> pegging the device to a Linux API we effectively limit the growth of the
>> device specification to as fast as the Linux API changes. I'm not fully
>> immersed in v4l but I don't think it is seeing any additional features
>> developed for it and its limitations for camera are one of the reasons
>> stuff is being pushed to userspace in solutions like libcamera:
>>
>>    How is libcamera different from V4L2?
>>
>>    We see libcamera as a continuation of V4L2. One that can more easily
>>    handle the recent advances in hardware design. As embedded cameras ha=
ve
>>    developed, all of the complexity has been pushed on to the developers=
.
>>    With libcamera, all of that complexity is simplified and a single mod=
el
>>    is presented to application developers.
>
> Ok, that is interesting; thanks for the information.
>
>>
>> That said its not totally our experience to have virtio devices act as
>> simple pipes for some higher level protocol. The virtio-gpu spec says
>> very little about the details of how 3D devices work and simply offers
>> an opaque pipe to push a (potentially propriety) command stream to the
>> back end. As far as I'm aware the proposals for Vulkan and Wayland
>> device support doesn't even offer a feature bit but simply changes the
>> graphics stream type in the command packets.
>>
>> We could just offer a VIRTIO_VIDEO_F_V4L feature bit, document it as
>> incompatible with other feature bits and make that the baseline
>> implementation but it's not really in the spirit of what VirtIO is
>> trying to achieve.
>
> I'd not be in favour of an incompatible feature flag,
> either... extensions are good, but conflicting features is something
> that I'd like to avoid.
>
> So, given that I'd still prefer to have a single device: How well does
> the proposed virtio-video device map to a Linux driver implementation
> that hooks into V4L2?

IMO it hooks into V4L2 pretty well. And I'm going to spend next few
months making the existing driver fully V4L2 compliant. If this goal
requires changing the spec, than we still have time to do that. I don't
expect a lot of problems on this side. There might be problems with
Android using V4L2 in weird ways. Well, let's see. Anyway, I think all
of this can be accomplished over time.

> If the general process flow is compatible and it
> is mostly a question of wiring the parts together, I think pushing that
> part of the complexity into the Linux driver is a reasonable
> trade-off. Being able to use an existing protocol is nice, but if that
> protocol is not perceived as flexible enough, it is probably not worth
> encoding it into a spec. (Similar considerations apply to hooking up the
> device in the hypervisor.)

I very much agree with these statements. I think this is how it should
be: we start with a compact but usable device, then add features and
enable them using feature flags. Eventually we can cover all the
use-cases of V4L2 unless we decide to have separate devices for them
(virtio-camera, etc). This would be better in the long term I think.
If everybody wants a single device that much, I think it should be based
on the current virtio-video. virtio-v4l2 spec can be developed out of
tree for those, who need 100% compatibility right now. Maybe we can link
it in the virtio-video, when it is ready?

> Sorry about asking all those basic questions, but I really rely on the
> judgment of people familiar with the infrastructure and use cases so
> that we end up with a specification that is actually usable in the long
> term. Too many details are likely to confuse me :)

No worries. :) Thank you!

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

