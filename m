Return-Path: <virtio-dev-return-12722-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB3CC77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 14:54:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E6B466846A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 14:54:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2A5C9865B6
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 14:54:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B6E2A986511; Tue, 16 May 2023 14:54:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3464986512
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 14:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684248847.077000
X-TM-MAIL-UUID: e05bebbb-e6bb-41c7-ac74-289a1a6675e7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnZKIFkBYwG8Cl7rOdszysW3d9Cl6ao+CPfe1ArZ6pzr0t5iDzdoTEAgcGLEWuXlCC7uKhAgGMzy2jXKEH+yxNfRD88FwKY6qlTgiPaxK9CR6GJ4mWgFOGMOng7SREZobFXQi9jO6Ad0biSaYO8tFvTZdYdM7vTTHaCnwq/X/o2Wzu8fYJHkTzvSwOy9QiWXbPTbKIMnJ1Pd0Ns2wkV6UD0XJMkTTFcVI1TmeapDMdYWODlHgA97Vh2wRRbwXbvAl0KxVKHZMp7pz9xudO/nfV+qdg640aiD3HYS4AMflifSjR9aBjIomYCtjO5RYTkGp7IRwYeF+n4JMS+vr1MC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO5OLEy+3CxLGgB8ptzKOiSZbNKd1kRmTzlygCfdRdY=;
 b=JFjBv5PspLZNt83cf7Nc1q6boe/AVxMUOYPUQkkuUDDmVLJrg6simQGSuR6aVtLSAYSgcv0zBL/gYR7fAiSlBul/TnMY1oGed1+SqYMIqHFcwh1968mozDwFmUOFP5gwxHGyh/PwS8G6aYe03r6F2Q2yONlDI4pSaIzpLXIIagsPed5Vsw8RsInyD4Qi6V3kOIIGdlfiovSWFie5r3NH79v5PDNj/njhoWghmhZR9jYaV1QyLZ1MvxeerJPuU8fSQeJiakXG16uqdik0sTHoKbNxwhEUOiTHDOn9PN2o3xXNdIjRIXFn+KLCvjVluCQF8x+tK6SGrtHCxfN39GJNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <7c44f2e4-1138-ff69-7cff-11edaec2ecbb@opensynergy.com>
Date: Tue, 16 May 2023 16:53:59 +0200
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
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
 <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
 <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
 <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::10) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB0108:EE_
X-MS-Office365-Filtering-Correlation-Id: ff50b5ce-9dc3-4e86-a627-08db561d643b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cxpo5AUMKaAj3bgZi4mc2R3MQAWGFuPkMGdyVctmpc6je72yQxsA/1Cp4yDg9GiE70fS9xWCtnoHDphkknHSPWZxfY5GNvzJtaJa7fH2p/3IdzweHcM3iKl7NuvMBFzVl5YQbOIMjUdVF8e30ou0/Qx0tNvoLW3RLhjITg9wRCoeQHUdlHR0d6gKEIWgMTeBS8pCupCbY9dpQ7y6iXUDb3WATyD60ZfA+Xwhizd52xXGXhgZKhY31cpGQ7VPNqzSDCVGv4CwplpKeIv+/3qiL3pQQ73dtDdQCqeyLVcY7dgWci8XBWe9MFofPrHfRm4ug+4e3pVFsuCDcJYkaxIYK4n8BnVj7kL/R5HBGrBBZud3OHs0DBFTUQ9hDBd9z8nOIo84rvozdnGYjoVQijguwn9PuNLGZhfmHDVsZPbUFy4SGRtqZRjbD1bNFXJo1eFI6FADEvZpWPmmeGQr8McZ47XEq22HHAOmBWc8ke4nr9Bxf3/bWP3D5m9KFTl1iq9tARXqYOKFBCxyYaehqUYSMIkhn6tQaaJFJmpN0nRi0OPTK+xzDMfPwbIO1r8U32px/ZIPMJp/tZ+SmkJw8HbSmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39840400004)(366004)(346002)(451199021)(66899021)(31686004)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(42186006)(966005)(54906003)(86362001)(15974865002)(36756003)(31696002)(83380400001)(66574015)(26005)(53546011)(186003)(2616005)(41300700001)(5660300002)(44832011)(2906002)(7416002)(30864003)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1FRVEpiZDhadUhkYW5EdExmZ3lDTGxqeXc0UkdOQkNmeSs3dHNIY2dsTGRK?=
 =?utf-8?B?djl0T2dLMEh0ZldiWXZhQUljRDV6Z0Iwb29vdEx4cGxuSnlOU29QMW1qQU0r?=
 =?utf-8?B?WUVUc2RpZ2pKKzg4RHo1aDJtdzZRTUJqL0g0YTZ1R1o2QnhPeS9PMzFiQm1t?=
 =?utf-8?B?QlNkY1VmVjM1TTZZY2pKUTBGbDFsWFk0SWxsMEIzVkxRZkVYbzB2ZFBFMzNl?=
 =?utf-8?B?c3hieG4rYlRlU3NmbWd3eTlRR1lLMkVPYnEwOTR1TmRCdGJJcWw5VlpIMVV2?=
 =?utf-8?B?TzU0U1ZiNmdEM0g3dXo2cDM5b2swMHJTZkl3ZW4rbktVOEhyQWw3MGZGYXdB?=
 =?utf-8?B?cStydFVFSDZXSS81bGN3N1MxM0hCSFhtNkpFYXJFdWtzTjJNWk5ua0oxeE9r?=
 =?utf-8?B?WmpWeGt2WFRHeWYvbXlTSnI2V2lhcjhtOEtoQWxOYWVNL0FLaHB0ZjZBZ3Ns?=
 =?utf-8?B?MDA3WU03N3BGc3o5TkhuNlh5NkFlS1pCd3pWd05FeVFNcEFwSVczd1QvRjE5?=
 =?utf-8?B?cExxN3ZkR0ovWXVaR2ovc2VvN085RjI3V3Q2NGRnRnZSMU5YY2J1K09JVTRx?=
 =?utf-8?B?cWpueVdNaVNhVnhoSWhrRDlEdzkxWUk5UEtZdFNwVG5MVllTMDR4UlFNQ3JO?=
 =?utf-8?B?TVZSbk9BcStLSjVGYk9GSS9HbTNRZFBYQ2ZOdW5IMjdMalpBM0ZvdXk1M0Vk?=
 =?utf-8?B?amFzUFJtamlGSHZWTkhkLzdpVHNKVkVTbnJnQmdiMkJqWkdpN2NoZWRnejZX?=
 =?utf-8?B?MnZwRHpuZ0pwck40UWpYUkl6T3Y4R1VOMzMxM2ZHRWV6NklKeTJCMU03M0Ex?=
 =?utf-8?B?SWhYMlpodGd3MTlWaElaTVY4c1h3UXVmOWVzSmhWZWk3L01EdVp1UkhMUDJH?=
 =?utf-8?B?bzZ0UXY3cnBSTllpRCtWbm9ZMmh6akpPWTJ6MGVKN0cxNFc0cGE1LzFFbzRP?=
 =?utf-8?B?SE9Wa25xZzBsYzhnM1Y2M3o1WWNKRWJyc1JOOTF1c1N3OHB0UG9YMDhuZlF1?=
 =?utf-8?B?QWNnOEZDTnhKajdWQVBCa0FQa3NHc0R1enFQRUJRSG83WktSSFVGNUsva2Zr?=
 =?utf-8?B?b24zb0FUY1ZwTGNRV1VJZmppbzg2R1duaGp0bnpEREFDQ1pXald4ZDNLTlpY?=
 =?utf-8?B?ODBJM2VCZHdaRWQrckFhOXN4ekYyL01iTGZJQTRuV2F6WGJGOUJrN0JTYUZW?=
 =?utf-8?B?Y3BXSmQrTWtFZDk2ckJGcGhjT1dxNFcrYmdLbXRjQkFtY3ZncWgvSDZVNWg2?=
 =?utf-8?B?ckxPSUNhNjVlNEZGSjJHQzd2dVdBWVNBL0RTNkRCNk9lVzlLWmZEUzZxVFJK?=
 =?utf-8?B?NWszL21Zako2UzRhV0xzbzcvL0Q5cGpycXM5UXVJaUk3dTBqU2JPc0o2Zkt3?=
 =?utf-8?B?ZURObk13RlFVZktUc2pTUWNwejg2MHNhVnZkZEdsRFZOMElLREVkMEZoNHor?=
 =?utf-8?B?NnpnSWpuQ3hPM1lEVU5sNmlwcVA5L0VuNEJTdWFYUXY5T1hvZGMxRGIveEFo?=
 =?utf-8?B?ZTdTTGtHNnBkV2NVdjAvSlB2MXdrbnJHOU4zckI1NzRhUzV2VDNCUXFNZGJP?=
 =?utf-8?B?enpBU3RiTVJyYlRQN0ZDcjVkZmRtcG5LNks5SnBxRGw1bzN2V3c0dk5VVnZz?=
 =?utf-8?B?V2h6WlMwVkN6T09HL0JVU2lEUzVrMlNheU9JcWFydVByZHZnRzJ4czJxR2Za?=
 =?utf-8?B?ZkNwNHVnOTVoVEY2dW0yMHRaeVVZd09IOVVhRXQ0aktGeXF4OEZrNGxJSTRo?=
 =?utf-8?B?ZEc0R2tySTN2L0xLMklza2hBK2pSZDhBYmNyYXRtMlRQYlRsRGdNaWFoWVNH?=
 =?utf-8?B?VUpxdU0rZ2FiQ2kwOWppY2dMQ3VFbDdsMExyc3htOWpwZi82MUJwY2o4SnRj?=
 =?utf-8?B?OHpKYUxqQldQQTlQdUM0SU5ybzNuaXdHQXdSRVAxVUcrK2YwNUFXcnVCZ0M3?=
 =?utf-8?B?Q1AybU1LaGtpS0l0WWg3WDg1eGpsNGZzb2pKN2VWbU83MzRKMXBHQTFiWlVU?=
 =?utf-8?B?L2l0ZDEzNThPWWczZC84SVAyS1J4aVo3R1RMZ1pRLzkwSGFrSWczZU1VOWlt?=
 =?utf-8?B?NGtZVncyd001NzU3VkNmUTgwOWR4RlBCanFtN2ptWEEycUQrVzZqWGM5UjB0?=
 =?utf-8?Q?HZXHuBTsGHQDvjznNbmgbuHZp?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff50b5ce-9dc3-4e86-a627-08db561d643b
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:54:03.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9IZRjGwR0QQe8wP/ZWwf8B4sAGy5D2/20z3kYcFaRIavoqskSUraFOsVEsidVmJHFvLomkyl9/u9YJ6pcdDJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0108
X-TM-AS-ERS: 104.47.11.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27630.000
X-TMASE-Result: 10--13.842900-4.000000
X-TMASE-MatchedRID: CxmI61mtwh//9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYLK6
	GmKppGdqLVqxk9o1HBxAKEp+2HkEbv27vtwnQ39AIi5n/oIUxv+/KQGKQH1rQFAoBBK61BhcGDr
	P8zNo4TwMf7Ce+LIFds5yw/YC8uhnp1reWSY5Jcf0hv/rD7WVZKPLTdfaE15XQmw1cPfvj6maY/
	lzalOje6e76VC6sRoK8uypKo/12dOrofp7IohGwyhvVjkRcuKhAajW+EL+laOtBiS9hFeaTOfE4
	NGuUaNHfWrgQNsTIWqUI512D01p9G7lkbyMKxttFDuTLTe6zcMR5c83KIxTTjjG1ABBh6LlUYh+
	XbvSa0glqqWTemaW5INFhuChNKBZJBgtEIxUn4FOKksNozKUfTa6AaQm7fhmN2zK9lb+laYJtgc
	1847JRWrffv7+FREl3CoThJDYrJ3vXN3A3XXzVAPZZctd3P4BGJDD5VSb847yG0yNmfugqvNaEi
	m+BfVwdJgyfwOr1l94BoHLZ4KzsuwTP3JxbBsKqFq6eukpTb86En2bnefhoKkUwB3MABAnXzwoV
	YXbtz57nHGWdZqBLwLvDu8IKN2y6NICqAQUc8/kNIw8RlACQ5Q7eT0DII9NpeDMqsfje3jEszoc
	m2L9xjpUbZQF2sP/SfYsIq+V09W1ttxVkfkm9jzHAJTgtKqwLKLocOycIiG1eP8DDIUUML3mJhW
	CLMZXa9r8chJWVC/GxMI2k6fgfQXEH283r206Z7RHc0AX9yHKLdLRjLKhp1J+6cuLn3ZGYxqmcU
	LrxeZUU8pQfbHPENwshKDotQVLUBOomz25VdF+yskgwrfsC30tCKdnhB581B0Hk1Q1KyLUZxEAl
	FPo8/cUt5lc1lLgkU6UkIr/V+20QRlrBF3eZdwYC5rxAU2l6wsOkaWKhDfCnU5oh2wH8obZjxRq
	LGEqgXq1Uf7HoYI=
X-TMASE-XGENCLOUD: c5ea310a-9beb-4840-afb2-a28d04252852-0-0-200-0
X-TM-Deliver-Signature: 1BBA65514789F6217E17FF8763344482
X-TM-Addin-Auth: vAiBINMczu8N5AEyBK9Z5Zkhb/qX3JL9TCGFnkAtN8hU8hpacggrqhEPYHP
	EUa3K5uW5XmPR+ADMQNOI8+uQWX6sTEqxCfQW6yd1xq/l/Kaw4PzYILJa2oBqVZTho4BM3xHUXj
	5bIpSxGp9Hm4F2KB5K9TbjueMnr2jP2Mnz5YlnnmRDXUeYxBxMD0cip/4lqHEO4NYUSCM8WoCw/
	4l8vhZ0a8pNd9tdvCxtVqbqPAG3Br717A9/fm9Ei1o6T/a1kkQhnyAK9IE+gXAHiL7lO3t4N0tK
	oG6xUwrQnGkTHYM=.kSXLMIgQYf8scXvTKllKvosaAY8U98wY51OMwfo6InzFaYUEo1JARK8eRA
	mTqp4FBZvFJMAGwbSGodk7D8uBnYJTj4/MnAg2tMG1d0B1lkyB8YZub4LzgDKfI151uPfAdHGy4
	Kg3LotzMvDpg6rao4n+ToYURwcRGNomV77e4Pq6gganwP2d/FyiCgwFXVHSTB3VW+4bomig7HAM
	VB3GvIQ8hScW7aNbimO4pQzabVTpINlcdkfIVLrnouCDvo0gF965MvG3WoQt5BK0N81ob1EXscZ
	cAqA9NieB8LklHH/4eQjo3LLZW+a0XAnlNRHW3qyWxOsqfAkawHrj6bYevQ==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 12.05.23 06:09, Alexandre Courbot wrote:
> On Thu, May 11, 2023 at 5:50=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 08.05.23 06:55, Alexandre Courbot wrote:
>>> On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>> On 03.05.23 16:04, Cornelia Huck wrote:
>>>>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy=
.com> wrote:
>>>>>
>>>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>>>>> But in any case, that's irrelevant to the guest-host interface, and=
 I
>>>>>>> think a big part of the disagreement stems from the misconception t=
hat
>>>>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>>>>> which is absolutely not the case.
>>>>>>
>>>>>> I understand this, of course. I'm arguing, that it is harder to
>>>>>> implement it, get it straight and then maintain it over years. Also =
it
>>>>>> brings limitations, that sometimes can be workarounded in the virtio
>>>>>> spec, but this always comes at a cost of decreased readability and
>>>>>> increased complexity. Overall it looks clearly as a downgrade compar=
ed
>>>>>> to virtio-video for our use-case. And I believe it would be the same=
 for
>>>>>> every developer, that has to actually implement the spec, not just d=
o
>>>>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>>>>> compatibility device (which I believe it is), then it is fine to hav=
e
>>>>>> both and keep improving the virtio-video, including taking the best
>>>>>> ideas from the V4L2 and overall using it as a reference to make writ=
ing
>>>>>> the driver simpler.
>>>>>
>>>>> Let me jump in here and ask another question:
>>>>>
>>>>> Imagine that, some years in the future, somebody wants to add a virti=
o
>>>>> device for handling video encoding/decoding to their hypervisor.
>>>>>
>>>>> Option 1: There are different devices to chose from. How is the perso=
n
>>>>> implementing this supposed to pick a device? They might have a narrow
>>>>> use case, where it is clear which of the devices is the one that need=
s to
>>>>> be supported; but they also might have multiple, diverse use cases, a=
nd
>>>>> end up needing to implement all of the devices.
>>>>
>>>> I think in this case virtio-v4l2 should be used as a compatibility
>>>> device exclusively. This means discouraging increasing its complexity
>>>> even more with more patches in the spec. virtio-video should eventuall=
y
>>>> cover all the use-cases of V4L2, so I think it is reasonable to use it
>>>> in both complex use-cases and in simple use-cases, where there is no
>>>> decoder/encoder V4L2 device on the host.
>>>>
>>>>> Option 2: There is one device with various optional features. The per=
son
>>>>> implementing this can start off with a certain subset of features
>>>>> depending on their expected use cases, and add to it later, if needed=
;
>>>>> but the upfront complexity might be too high for specialized use case=
s.
>>>
>>> I don't see that many negociable features we can provide for a
>>> decoder/encoder device - at least not many that are not considered
>>> basic (like guest buffers). In terms of provided features for codecs
>>> virtio-video and virtio-v4l2 are essentially equivalent.
>>
>> Actually I see a lot of potential in using the virtio feature flag
>> negotiation for virtio-video:
>>
>> 1. We already have some feature flags related to memory management.
>>
>> 2. I think it would be great to take V4L2 controls negotiation and turn
>> it into the feature flags negotiation. I really like this idea and I'd
>> like to implement it. Not all the controls at once, of course. Still it
>> would be very easy to port more given the existing process. They
>> correspond well enough to each other, I think. This way we don't need to
>> introduce something like the VIDIOC_QUERYCTRL/VIDIOC_QUERY_EXT_CTRL, we
>> don't need two mechanisms for feature negotiations (like it would be
>> with virtio-v4l2, right?), also all the features would be in one place.
>> Then we can directly reference some enums from V4L2, like
>> v4l2_mpeg_video_h264_profile or v4l2_mpeg_video_h264_level. That's what
>> I call taking the best from V4L2.
>>
>> 3. We can have things, that V4L2 doesn't support in their stateful UAPI.
>> For example, dequeuing output buffers in decoder order.
>
> ... provided the host can do that (i.e. has a stateless decoder
> interface). What is the use-case for this btw?

We have discussed this already. All the relevant quotes can be seen
closer to the end of the email here:
https://markmail.org/message/skotipxlqfiijj7c#query:+page:1+mid:hvkyxsj4tjy=
q56hj+state:results

>>> The question is more: do we want a decoder/encoder specification and
>>> another one for cameras or do we want something that covers video
>>> devices in general. And is it desirable to reuse an already existing
>>> protocol for communication between a non-privileged entity and a
>>> privileged one (V4L2) or define our own?
>>
>> Please note, that virtio-video could be extended to support everything
>> V4L2 does in the future. Including cameras if necessary. So it can cover
>> video devices in general too.
>
> That's a very, very bold claim, and if you do you will inevitably need
> to add things that are not relevant to the codec case, which is your
> complaint about V4L2. Not to mention the many new pages of spec that
> this will require.

Hmm, you're right. My statement was not specific enough. Indeed V4L2
does a lot of stuff. I'll rephrase.
I think, virtio-video could be extended to support at least the more or
less basic devices like USB cameras, maybe a little more. Everything
beyond this is possible, but should be avoided.

>>> About the latter point, Alex Benn=C3=A9e mentioned that it was difficul=
t to
>>> find the engineering time to define virtio-camera. And virtio-video
>>> has also not been particularly fast to come together. virtio-v4l2
>>> basically serves us both on a plate for a lower effort.
>>
>> If we talk only about codecs, the effort is lower only in case you have
>> V4L2 codecs on the host. Otherwise the effort seems higher.
>
> The effort is lower in terms of spec writing, and also lower if your
> guest is Linux as you can support all video devices with a single
> driver. That's a very large portion of the virtio users here.

As we found out already, the V4L2 probably has to be patched to be
actually useful in virtio. So I'm not convinced that more complex
devices wouldn't require more patches. So in the end it is hard to
compare the effort.
For the spec I'm also not so sure about that. I think we'll have to see
it first and let it pass a couple of review rounds.
Anyway the effort writing the devices would be higher in cases, when
pass through is not possible. That's our use-case. I think the goal of
making it easy to write devices should have higher priority compared to
the length of the device part in the virtio spec.
But I think we already wrote all these points, so we're making circles.

>> I also hope to be able to update virtio-video at a faster pace. Please
>> let me try.
>
> Please hold on a bit - there are two things here.
>
> 1) I'd like to settle the virtio-v4l2/virtio-video argument first to
> make sure we don't get two things clashing head-on. As far as codecs
> are concerned we certainly don't need both. Cornelia, I think we'll
> need you to make a call on this, or at least tell us what you need to
> make the call. If it helps I can send a draft of what the virtio-v4l2
> spec would look like, it should be relatively short.
>
> 2) I (and other ChromeOS contributors) have been driving this spec so
> far and while I think virtio-v4l2 is a better solution, I have not
> said I would give up on virtio-video if virtio-v4l2 was not adopted
> and will keep iterating on it in that case.

It actually very much looks like you gave up. I mean, you developed it
for years, and now you'd like to throw it away. Well, I meant something
like "please have some faith in my ability to update virtio-video at a
faster pace". I think I already have the permission to continue the
development. You know, OpenSynergy also spent some time on the
virtio-video. This includes the draft v1 version and the V4L2 driver. I
think this was kind of an informal agreement between us, that you do the
spec and we do the driver. It didn't work well enough since draft v4, I
think. Now as our interests are not aligned anymore, it is fine to
continue separately. I'm not going to wait until you change your mind on
virtio-v4l2. Obviously you're very busy with it right now. If I stop and
wait now, we won't have the video device in the 1.3 release for sure. I
think when we are ready to develop virtio-video together again, we'll
need a better agreement.
That said, I very much appreciate your efforts with the spec. It
definitely received a lot of improvements.

> That said, your contributions are of course welcome if you have stuff
> written down that you want to include. The current virtio-video spec
> is available here:
>
> https://github.com/Gnurou/virtio-video-spec
>
> I'm writing it in Markdown (virtio-video.md) to avoid dealing with
> LaTeX directly and use a pandoc filter to convert it before submission
> - there is a Makefile that takes care of that. Feel free to send a
> pull request with changes you have worked on, including your
> Signed-off-by in the patches so I can carry it on into the v7 patch if
> we go that route.

Sorry, I tried this, but I had a lot of troubles with any maths in
Markdown. So after some time I just moved to TeX. Now I have a great
development environment for TeX. I have the final pdf file on the right
side, and it gets updated every time I save a file. I can immediately
see the formatted result as it would be in the spec. So I'd prefer to
stay with TeX.

Also I'm not completely sure if the OASIS IPR license allows this kind
of workflow. Simply sending patches to the mailing list seems like a
safer choice. Could anyone please help understand if it is OK when
several developers work in a separate repository and then one of them
publishes the combined changes to the mailing list?

>> This is understandable, that working on the specs takes time. That's why
>> I'm all for making room for everybody to work. I think eventually
>> virtio-video or virtio-video + virtio-camera can replace virtio-v4l2. I
>> strongly believe this is a better solution for the long term.
>>
>>>> In this case I'd prefer to have the simpler device first, that is the
>>>> current virtio-video, then to add features incrementally using feature
>>>> flags and taking into account the virtualization context. V4L2 is a
>>>> complex thing from a different context. They already tried to carve ou=
t
>>>> some of the use-cases like stateful decoder/encoder API, but this work
>>>> is not finished (struct v4l2_buffer can serve as an evidence). This is
>>>> like dissecting a monolith. Also it has to be patched to make it more
>>>> appropriate for virtualization (we can see this in Alexandre's PoC alr=
eady).
>>>>
>>>>> Leaving concrete references to V4L2 out of the picture, we're current=
ly
>>>>> trying to decide whether our future will be more like Option 1 or Opt=
ion
>>>>> 2, with their respective trade-offs.
>>>>
>>>> I'd like to rely on opinions of people, who know more about virtio
>>>> development and goals. I would be happy to present or reiterate my
>>>> arguments to anyone interested if necessary.
>>>>
>>>>> I'm slightly biased towards Option 2; does it look feasible at all, o=
r
>>>>> am I missing something essential here? (I had the impression that som=
e
>>>>> previous confusion had been cleared up; apologies in advance if I'm
>>>>> misrepresenting things.)
>>>>
>>>> Indeed some of the previous confusion has been cleared up. But not the
>>>> key thing. Alexandre still claims, that this patched V4L2 UAPI pass
>>>> through is only marginally more complex, for example. I don't agree wi=
th
>>>> this and I have evidence. We haven't finished discussing this evidence=
.
>>>
>>> Are you talking about v4l2_buffer?
>>>
>>> https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/buffer.html#struct-=
v4l2-buffer
>>>
>>> I think you implied that some of its fields were not relevant for
>>> video decoding or encoding, which if you examine them is again
>>> incorrect. That also answers your question of why the stateful decoder
>>> spec did not mention the valid fields - because it is documented on
>>> this page, which tells exactly which fields the driver/device are
>>> expected to set for each queue.
>>
>> I'm talking about struct v4l2_buffer, yes, but not only. Also about
>> struct v4l2_plane, enum v4l2_buf_type, the buffer flags, enum
>> v4l2_memory (but this one is comparable to virtio-video), timecodes.
>> For example, the way the fields in the struct v4l2_buffer and struct
>> v4l2_plane are filled and interpreted depends a lot on the type. Here is
>> the enum v4l2_buf_type:
>>
>> enum v4l2_buf_type {
>>           V4L2_BUF_TYPE_VIDEO_CAPTURE        =3D 1,
>>           V4L2_BUF_TYPE_VIDEO_OUTPUT         =3D 2,
>>           V4L2_BUF_TYPE_VIDEO_OVERLAY        =3D 3,
>>           V4L2_BUF_TYPE_VBI_CAPTURE          =3D 4,
>>           V4L2_BUF_TYPE_VBI_OUTPUT           =3D 5,
>>           V4L2_BUF_TYPE_SLICED_VBI_CAPTURE   =3D 6,
>>           V4L2_BUF_TYPE_SLICED_VBI_OUTPUT    =3D 7,
>>           V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY =3D 8,
>>           V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE =3D 9,
>>           V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE  =3D 10,
>>           V4L2_BUF_TYPE_SDR_CAPTURE          =3D 11,
>>           V4L2_BUF_TYPE_SDR_OUTPUT           =3D 12,
>>           V4L2_BUF_TYPE_META_CAPTURE         =3D 13,
>>           V4L2_BUF_TYPE_META_OUTPUT          =3D 14,
>>           /* Deprecated, do not use */
>>           V4L2_BUF_TYPE_PRIVATE              =3D 0x80,
>> };
>>
>> Of these 14 cases we only need 2 for the codecs. Right?
>> Also the flags. There are 22 of them. Are they all needed too? I don't
>> think so. We only have like 5 in virtio-video at the moment.
>
> Upon reading the V4L2 spec it is pretty clear which queue types are
> valid for each device, and anything other than CAPTURE_MPLANE and
> OUTPUT_MPLANE is unlikely to be used anyway.
>
> We are really splitting hairs here and this looks like a wild goose
> chase for software purity - even within virtio-video there are already
> flags that only make sense for an encoder, and you cannot remove them
> without defining new more specific structures and complicating things
> overall. If you extend virtio-video to support more use-cases, you
> will end up with more of these as well. So seriously, why is this such
> a big deal when the instructions on how to use these structures for
> each use case are at the other end of a link click?

I don't agree with this description. I have written my arguments several
times. It took me a lot of time to write all these emails. It is very
disappointing, that you still don't seem to take them seriously.

>> You posted code for filling v4l2_buffer in one of your previous emails.
>> What I'm trying to say is that a person, who doesn't know this in
>> advance, will have a hard time writing this same code if they only have
>> the virtio-v4l2 spec.
>
> Well yes, the counterpart of virtio-v4l2 being shorter is that you
> need to refer to V4L2 as well - that's actually the point, to reduce
> the burden on virtio by reusing a spec that already exists and
> referring to it.

As I wrote, I don't agree, that reducing the burden on virtio is our
primary goal.

> Earlier in this email you mentioned reusing structs like
> v4l2_mpeg_video_h264_profile in virtio-video, that creates the same
> dependency to the V4L2 spec. The difference is how much we are taking
> from it.

Yes, exactly. I think taking all of the V4L2 spec is too much. I'd
prefer to only take the parts, that are well-defined, well aligned with
virtio and don't need patches on top.

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

