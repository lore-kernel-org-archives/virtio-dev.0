Return-Path: <virtio-dev-return-12476-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F280CC77B7E
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 07:47:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 20E262AED9
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 07:47:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2336986686
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 07:47:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C84A2986681; Fri, 28 Apr 2023 07:47:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6005986682
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 07:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682668071.740000
X-TM-MAIL-UUID: 07c21317-86d2-4226-9c71-7b3130466ee3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH/TTEbGOKVytG6pgGKYTwHTU0RI6J8yeyrfq+vLGRzJSnUhYDPxw6Ya96eEaHl353BuwObqc5nEtw/dVb6v7pYbYzrlwVbmwGbIO3teSVDsybiLyIjBPg3Twc9YZYujJRnx2UM+44t2EeY6JI1T6xIPeihdyhOcfc9Taesr2+N5j5NgLnHo/T+a9X5h56I1Pm2wf1ql7z0gX7yKObsm6sgtjfmTCjklYmOFIpzhyRi8t1fsvn0lzC3ARH6XfoJ4xNdRQyqhqs/yqb4Jgi68VV4SHuNgu2mB/ilyc77xeM6cXeBs7cGZSU0iXNJRVA9h8uDEzKPD5ZZAkGCMEaWDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APKze/3oVcTr/s7QOIzQrOA6T2HawGn31tdneIgivxY=;
 b=kkGBymudVwcIVR6x/RRPyxfDODrCbv05q20NXEX/HaGjtwsGYBSP8Fcx5/cWNXxgv25RBn//y3A86PlsxG7giJ93WG6FF7sGF1/jZN5KWmmD2qzERTSusyz5gZP9e4MXwT5sp4aFnU+zqMcCpfkxnIpJS6gmViWmEgINWcYsBMVQzH+Bm+pUHEV4buo0gWrcdEgKYaG7k4PJE4vqQYr8d8wD9QkQbd9jeejHJPQ7hmratxtstqNolblABd5BG3tidg8pdpxjclLcgpsIxUCzOV7Fb6rEDr2nRPZtJ3qrmKSy3gB7xG65uL+6yH2/AeadJNzh8hLhbW849Pl+xBJVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
Date: Fri, 28 Apr 2023 09:47:46 +0200
Content-Language: en-US
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
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
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
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::6) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR3P281MB2941:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7f1879-dee4-4a35-52ee-08db47bcdd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KdjqPtNT5NkRNtqNHenUyNjwZLaGBorCl8ZbQM/ZVfuw2pMseMYEXkFdMoBWr0+wXPECFkBBN6FZmP/Ra8uqxwXmnFWmq76Gt7M8nnMrDWEFANlLhA8340mn2pY7KSGKV7U3za/D9qxMkC15JW88VbPNKQD7VdxSzOkDwLkCXNt0BJkQx5yk1hGcO5EDQ15my2ZdH+zlTK7coyWA0G+ZpEuliPdioDptudrKn6RbrGkfar519e0daFC0BS4nF+P2fM/S69g8RwJbak/jDg5uIgHIKV8VCqOVGaGLsVPUw4mz2SmT7D9rfhru1PWc3vZRBQRPVsNkEL/LFsFaABjfSLrj6fhpuoXQUgvl22GO1yz5BppAnH12x4+zlnRsG6szCOLueuQe98Z74cvp8x3ZYqMJzL5KkNG/scs+H5/h6M/4E9KlrXZ0bvp3bugDbAWiDSJ6WmbnRRkWFWWGqVPGLiDpKt4cjRfH4XrY/K25UUAc7r0qqdm/3fAzNe7COOSItIJTLm+W6XSrZ6f9HoKgpq+Y3dUw67T7oIkaPVgDDRo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39840400004)(366004)(451199021)(5660300002)(316002)(8936002)(8676002)(7416002)(41300700001)(44832011)(38100700002)(66556008)(66476007)(66899021)(83380400001)(66946007)(30864003)(31686004)(2906002)(66574015)(6916009)(4326008)(186003)(2616005)(54906003)(42186006)(86362001)(36756003)(966005)(478600001)(31696002)(53546011)(26005)(15974865002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJLaWlENEc0MzhtZ2hYdVBpeEo4ejZKUkZ0eTBGUGgzd0hCbjV2ZEFsdUV3?=
 =?utf-8?B?ZUQzQ0NaNWpoblFnbVU3QVpwSE9KT0ZlYW4vM1JkQ1lQSzIyektKMXJWbjZa?=
 =?utf-8?B?OUppMGoxNzFjckZVaWw3RjFZYjhzUXRYSEs2UER5Z2ZNdU9PZlRBYW5OQlVC?=
 =?utf-8?B?alhLSzlRYmJwbmpETFFhRzlMTmJGZDhxRitZTHlmQTVDOFY1d2s4M1pIS2N5?=
 =?utf-8?B?T3Y5dVVERVpsdDJJVjRTdUswR20xMXBoSEtaaFdJcFVYR2xOMHEwN0ZDTVBZ?=
 =?utf-8?B?Mmplc09hcllaWDhJZFVweGpsMHV2THdEUGZBTlZOeDErOWpzWU5TbnQwOTBu?=
 =?utf-8?B?S0xQZ25XR0Rkam56Z2thTmljbUQvcXdyQU9wTGx1bTJGcDRHTktHOGlrZCt4?=
 =?utf-8?B?cWxyUnNlUDVRcXRtdGlURHFLSXYvcGZwVDVsRGsrOGxxdSt3N1VBck5Bbk5K?=
 =?utf-8?B?emt2NWJ5UzJpQWV2bGIrZy9OaXduV1h2QmFhMHdBbk5yeEhQV1Z5VDBmZnJC?=
 =?utf-8?B?UE5XYVhvWjNmekxPR0ltbHp6TlgvTSs4N2xHQ3BQcVhKSk1aUUhxYnF6bW1K?=
 =?utf-8?B?UFlaSFc1dkl4djNvbGlnbzRYSGN1V0xQcWlac2oyZ1hZTkJ6YTBHSFZLVXY2?=
 =?utf-8?B?cjlpL2g0VnpBQUJ2bXhQS3NwOU5wby9HaWNMaFoxUWx5bEdBNVlSVjJGYm4w?=
 =?utf-8?B?S1pnOURBUTcycmR0N2x0TXhTb1JzOXVaN1NGcWlQR29qNWMrdWJoV1BCTEx6?=
 =?utf-8?B?QldSNkZmWGQ1M21yWWFKR21RTStxOEtPS2ZLeHErMXdpMHJyMmppVHJNRGov?=
 =?utf-8?B?TXZlejhOZlI0VnNOeWh0WU5lTjZOMGdQRjhqc09BMFNYWVRvT3NnV1VrNGFS?=
 =?utf-8?B?d0JqaStPYlhqODVieFVRUlhQTU9hQlR2TmRpWHVBbkZ2Zk5ZUW9LRnpVWG1X?=
 =?utf-8?B?YXZUbVhMVzYzN3BqTW1pdzc1SmJITitScVdVYVE5WTVtWEVadGpPbzFHNFo2?=
 =?utf-8?B?OXZ3cmJGV2VNRFNxZFgwRzZINzRRSTZuSkxDZjYxVUo2QVlEbEVMRFdrNE1C?=
 =?utf-8?B?REd5MlFVS0VlVXRWK0E1WmJRVDUwZXBUN0RRdERWd1BMc1REUlhVZUp3VWJl?=
 =?utf-8?B?ZXRXWEVBUlhvRDBrMElDVkRINGFSaUVvM0NyWVlHZDg0Vkh3ZnRDT28vWUVz?=
 =?utf-8?B?R1pMeEdaTU5CeXd5bVEvdURmemlwUjZvdkpnNU9aSEZoQ0JyRGIzWkpKdUdU?=
 =?utf-8?B?N2c3ZGZIUEtCd3lnZW9OMmtLSnVGblZyWGdBaUZsLzVZanF4ampLR1VZa3Zo?=
 =?utf-8?B?N0I1QWpTZy9wR29QNnQySXB1V2VlUG1IVFprR0R4N3pHK2tpQWxNRVZJMG9O?=
 =?utf-8?B?YllabXlKMnBIeTR2MDN0Ukc4Y2tvanFrNlI5VjlTemZzbGsyd0wxV1ZybGcr?=
 =?utf-8?B?cFQ0R3VUV2QvV3FYU3hHQlJ2WXBOYXlzK1N1b296VmRMWWhVd2VrSTlvRzJ4?=
 =?utf-8?B?aVlMNVNvM2U5VU5YMU0rMU1mRGRpWUt2dkZzMXlOeXBtamdZTm5SYXcvb0ha?=
 =?utf-8?B?TDdaa201TDhNc3BmdWdYUk1oZmU5Tzl1eTRQSkJaZGF3L2hhUHM5Wno3TWk4?=
 =?utf-8?B?a0JRT2JGUmN2bTRSK2IrYnFiUFZLK1BKeUFhZDN4MjF0Wi9OWlFRcnNUTDk4?=
 =?utf-8?B?TEl1TEY2ZkplVVBHYlVRZ2c2RjJ2eHRGYXhOR24zZzZzUzVIOXZrYTlkTEUw?=
 =?utf-8?B?S01aYytRVFNreHZvcEZ5UGhEaVlFTFlHU0xGME1YclVnOEkrQXFvUmV3ZlpG?=
 =?utf-8?B?TnVYREE3SkRNODdGdFdORHlGcXFadWljUnpSREJRWXg1NU5DV1BoSlRQK0xz?=
 =?utf-8?B?Tk9GWGlqVDRibmhIVDhuNFptcEpVbzNCT0JpeDFnL2tmQ2oxTnlyOGtVRW9i?=
 =?utf-8?B?WDdrZ0VTbWRpcnpJSjdMejdpQWg5dDJITm4xSGh4SUtLNkpQMmlDRU9XK3pF?=
 =?utf-8?B?Qlh4dlNIR2ZmNFRLTkRiU3NaeUVGSDZDUnE5M0s2Y2tUeFFwbThhcC9xai9l?=
 =?utf-8?B?UFcrVkgrMUpQbUd4ZTV5bnJqMk81SXlJd2NFd3IrUHpTRGREY05YN2lUNmdm?=
 =?utf-8?Q?BhsJzRbi0hgkjZEJCLzN4Ih6s?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7f1879-dee4-4a35-52ee-08db47bcdd81
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:47:50.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YrrCjopQOclMzhp73Icy5SxuCm+2sJGmRNKhbl0/p0JI5TNXC4gJq684uSzCeRD9+9/0vVGGOvoBvfOy4FdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2941
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.006
X-TMASE-Result: 10--30.893900-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdlEv6AItKWF/GG
	5PZMzxFoSJMpuNZVDMj7SMNvd0KhY2dkza/sEr/bTipLDaMylH1lH44U2Ru12g6QlBHhBZuwh/E
	iWLGaPFKP9u+1+GFcS77MjnGq0ZbCs0pnWOAJ983O0qvSSPZDm3iywgNDw+2onhD4vcFcha7UKH
	jPpSVKRLk+TRtvZ0rpyA5RTZwM2e3SlUwSXNXPcfQAclqqmRB8AajW+EL+laPHBGR0WyQqAkopD
	+RCCRBkeVCL4AZCQ9rPbp196kml41y8LZtP0/3O3u5w3Ea2Xmgcsx3IH4sq3NZ5C2tydwt9KlbG
	+C+eP5qQ6tag/ox2gDwSas/EhcgSFerRtFceXJiIf3m0sUfx5/lSepWcgdLP8z0YrPW2jLA5Epm
	2enJ8rpo6GxI9r75nsRXzn1Y2kZ/rMkbZOfsleM2CuVPkCNzusk61leL8Ml+pn48UGTbL94zREx
	x/TfU2Hx3XZ0DNWGzT6lH4RrlwghJn3eCCZHA5+GYt8f/VhTvPFq5A6gp9az+B/tp8itBTCSfie
	ByOJzz6IqNGMKft6N2RzcgmyrvvX+fGOprXA73fqVBdB7I8Uel782vYr/kHuqWf6Nh7tmE02lCz
	uyrvyCaF4XQyYG9OMagTEj7fGJLMuT1xFRinI6EtILqFekmXpR+m8tBi6ZJ9qwILk+/C/sAD7EQ
	XJBPW7vc++nrew6PB3TStQsVOL0JQic2Ku7fAzusEIFLkpy236rOEul8OHx/Nr4idxLx/LIHZB0
	nMVDFRsOm1VJTji01kA/urPNIDEXK8SvgHSu9+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+sikGUtrowrXLg=
X-TMASE-XGENCLOUD: 4899f25c-437a-49da-8836-b9f2ddee945a-0-0-200-0
X-TM-Deliver-Signature: DF6968C0B6D87CB865EB5E8DA54033EC
X-TM-Addin-Auth: zOufTW2yDduop3bVdYrcs+In5E+18Hz8GOvNWo1b/cTt3vqGsLk7jSccEL3
	GUdH3RLGUaWmhRz2mJEZYwWkxpG80uP93x+W+XZUKutSDp8b7bynzkWJFQgJ7g82utxAyiop+RV
	uJMSa7x7v+qrL6OJq7ItP/wscsAYox1o59Rs9P7dxx91SvnUfbtDi7ercIqyHz6VDAPpytd4/PK
	+wAUVau0Ebk5RYYPYaFF3zG/W1JPP9h8+RazphEFBJwSc0rc2OV5/kAeW3OKHdofuIHijVWmwBF
	0M4C45ZDpePlkwk=.BgqHZSrVVKFbQXf7vEo6PBr/Qvf60vPHYDTMlErTpODi+KxFgJO9ViyvVQ
	N37wxHSueR+bQ7d43jkVjgJdpaPRgcSukLAUrEQvgydvvTMPcu/3bLFbGDIow3TDRzbYD/2lRJC
	YgifVFgm3CB17siDURnaeDJPPpOd0auTjTzCkJC93MpUlbopI5G8RLATSa0dmFs4aQ/VjoZ9njM
	aXH5Mc/UDTbImJ46FsiNUk9V2FDj6BNV4KjIY9Ld8BJL4OI6Pf7LL7ezRvfObgkYymW0N2bexJV
	3TuUiIdATGhk6SjFYiod7sRTSYFPaB/vBwLtmZmG9R4Y5HAGHh1RGsp0f2w==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 27.04.23 15:16, Alexandre Courbot wrote:
> On Thu, Apr 27, 2023 at 12:11=E2=80=AFAM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 21.04.23 06:02, Alexandre Courbot wrote:
>>> Hi Alexander,
>>>
>>> On Mon, Apr 17, 2023 at 9:52=E2=80=AFPM Alexander Gordeev
>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>> Hi Alexandre,
>>>>
>>>> Thanks for you letter! Sorry, it took me some time to write an answer.
>>>>
>>>> First of all I'd like to describe my perspective a little bit because =
it
>>>> seems, that in many cases we (and other people writing their feedbacks=
)
>>>> simply have very different priorities and background.
>>>>
>>>> OpenSynergy, the company that I work for, develops a proprietary
>>>> hypervisor called COQOS mainly for automotive and aerospace domains. W=
e
>>>> have our proprietary device implementations, but overall our goal is t=
o
>>>> bring open standards into these quite closed domains and we're betting
>>>> big on virtio. The idea is to run safety-critical functions like cockp=
it
>>>> controller alongside with multimedia stuff in different VMs on the sam=
e
>>>> physical board. Right now they have it on separate physical devices. S=
o
>>>> they already have maximum isolation. And we're trying to make this
>>>> equally safe on a single board. The benefit is the reduced costs and
>>>> some additional features. Of course, we also need features here, but a=
t
>>>> the same time security and ease of certification are among the top of
>>>> our priorities. Nobody wants cars or planes to have security problems,
>>>> right? Also nobody really needs DVB and even more exotic devices in ca=
rs
>>>> and planes AFAIK.
>>>>
>>>> For the above mentioned reasons our COQOS hypervisor is running on bar=
e
>>>> metal. Also memory management for the guests is mostly static. It is
>>>> possible to make a shared memory region between a device and a driver
>>>> managed by device in advance. But definitely no mapping of random host
>>>> pages on the fly is supported.
>>>>
>>>> AFAIU crosvm is about making Chrome OS more secure by putting every ap=
p
>>>> in its own virtualized environment, right?
>>>
>>> Not really, but for the discussion here you can assume that it is a
>>> VMM similar to QEmu with KVM enabled.
>>
>> Thanks for the clarification. If my idea about your use-case is not
>> totally correct, then it would be very helpful if you can provide more
>> details about it.
>
> It's nothing fancy ; Linux host, Linux (e.g. Android) guests.

Thanks for the explanation.

> But
> virtio being a standard, we should focus on making something that is
> usable by everyone instead of individual use-cases.

In an ideal world this would be possible. But in practice we have
various constraints and priorities. So sometimes it makes sense to
achieve more by digging in different directions instead of arguing
endlessly.

>>>> Also this mode of
>>>> operation is not supported in our hypervisor for reasons mentioned
>>>> above. So in our case this PoC doesn't yet prove anything unfortunatel=
y.
>>>
>>> I did not have your use-case in mind while writing the PoC, its
>>> purpose was to demonstrate the suitability of V4L2 as a protocol for
>>> virtualizing video.
>>>
>>> Now if your hypervisor does static memory management and pre-allocates
>>> memory for guest buffers, then the V4L2 MMAP memory type actually
>>> looks like the best fit for the job. There are no tokens like virtio
>>> objects UUID to manage, and the MMAP request can be as simple as
>>> returning the pre-mapped address of the buffer in the guest PAS.
>>>
>>> If instead it carves some predefined amount of memory out for the
>>> whole guest and expects it to allocate buffer memory from there, then
>>> the USERPTR memory type (which works like the guest pages of
>>> virtio-video) is what you want to use.
>>
>> It doesn't look like a good idea to us. This means preconfiguring memory
>> regions in the hypervisor config. It is hard to predict the amount of
>> memory, that is necessary. If we allocate too much, this is a waste of
>> memory. If we allocate too little, it won't be enough. Then we don't
>> know yet how to make V4L2 allocate from that memory. Then this memory
>> has to be managed on the host side. And memory management is exactly the
>> thing, that causes most security issues, right? So overall this is very
>> tedious, potentially wasteful and not flexible.
>
> My last paragraph mentions that you can also let the guest manage the
> buffer memory from its own RAM. Or maybe I am missing how memory is
> managed on your hypervisor, but if that's the case elaborate on where
> you want the buffer memory to come from.

Hmm, I think what you write is indeed not different from using guest
memory as it is done in virtio-video. This maps to USERPTR indeed.
Well, it is nothing special. The hypervisor allocates memory for the
guest, then guest is free to manage it. It can also give this memory to
the host.
It is possible to statically create another memory region, that is
managed by the device side and is accessible by the guest. But as I
wrote this is not what we want for various reasons.

>>>> Static allocations of shared memory regions are possible.
>>>> But then we have to tell V4L2 to allocate buffers there. Then we'll ne=
ed
>>>> a region per virtual device. This is just very tedious and inflexible.
>>>> That's why we're mainly interested in having the guest pages sharing i=
n
>>>> the virtio video spec.
>>>
>>> I'll be happy to update the PoC and make it able to use guest pages as
>>> buffer backing memory. It just wasn't the priority to demonstrate the
>>> global approach.
>>
>> Great, thank you. If you have a concrete plan already, I think it could
>> be beneficial to discuss it now. Otherwise I'd prefer to keep working on
>> the current approach until I see something concrete.
>
> Just give me a couple more weeks and I think I can produce the code.
> But I'm afraid you have already made up your mind anyway.

I had indeed. So IMO it is pointless right now. I simply wanted to have
a detailed plan just in case and make sure, that we both understand it
in the same way. If in the end we're forced to compromise, than this has
to be implemented (or reimplemented?).

>>>>>>       b. For modern cameras the V4L2 interface is not enough anyway.=
 This
>>>>>> was already discussed AFAIR. There is a separate virtio-camera
>>>>>> specification, that indeed is based on V4L2 UAPI as you said. But
>>>>>> combining these two specs is certainly not future proof, right? So I
>>>>>> think it is best to let the virtio-camera spec to be developed
>>>>>> independently.
>>>>> I don't know if virtio-camera has made progress that they have not
>>>>> published yet, but from what I have seen virtio-v4l2 can cover
>>>>> everything that the currently published driver does (I could not find
>>>>> a specification, but please point me to it if it exists), so there
>>>>> would be no conflict to resolve.
>>>>>
>>>>> V4L2 with requests support should be capable of handling complex
>>>>> camera configurations, but the effort indeed seems to have switched t=
o
>>>>> KCAM when it comes to supporting complex native cameras natively. Tha=
t
>>>>> being said:
>>>>>
>>>>> * KCAM is not merged yet, is probably not going to be for some time
>>>>> (https://lwn.net/Articles/904776/), and we don't know how we can
>>>>> handle virtualization with it,
>>>>> * The fact that the camera is complex on the host does not mean that
>>>>> all that complexity needs to be exposed to the guest. I don't know ho=
w
>>>>> the camera folks want to manage this, but one can imagine that the
>>>>> host could expose a simpler model for the virtual camera, with only
>>>>> the required knobs, while the host takes care of doing all the comple=
x
>>>>> configuration.
>>>>> * The counter argument can be made that simple camera devices do not
>>>>> need a complex virtualization solution, so one can also invoke
>>>>> simplicity here to advocate for virtio-v4l2.
>>>>>
>>>>> My point is not to say that all other camera virtualization efforts
>>>>> should be abandoned - if indeed there is a need for something more
>>>>> specific, then nothing prevents us from having a virtio-camera
>>>>> specification added. However, we are nowhere close to this at the
>>>>> moment, and right now there is no official solution for camera
>>>>> virtualization, so I see no reason to deny the opportunity to support
>>>>> simple camera devices since its cost would just be to add "and camera=
s
>>>>> device" in the paragraph of the spec that explains what devices are
>>>>> supported.
>>>>
>>>> Well, for reasons described above it still seems perfectly fine to me =
to
>>>> have separate devices. Ok, the argument, that this approach also seems
>>>> more future-proof, is not a strong one.
>>>
>>> Please elaborate on its weaknesses then.
>>
>> Well, as you said basically. The weakness of the argument is that the
>> virtio-camera is not yet published, the KCAM is not merged yet, so yeah,
>> the future is not clear actually.
>>
>> BTW I just thought about one more case, that is already real: sharing
>> camera streams with pipewire. I think pipewire doesn't provide a V4L2
>> UAPI interface, right?
>
> I believe it does: https://archlinux.org/packages/extra/x86_64/pipewire-v=
4l2/

Oh, indeed. Thanks for the link!

 > This package contains an LD_PRELOAD library that redirects v4l2
applications to PipeWire.

Well, it is cool, that they did this for the compatibility. But this
doesn't look clean and straightforward enough to use this for a new
development.

> But in any case, that's irrelevant to the guest-host interface, and I
> think a big part of the disagreement stems from the misconception that
> V4L2 absolutely needs to be used on either the guest or the host,
> which is absolutely not the case.

I understand this, of course. I'm arguing, that it is harder to
implement it, get it straight and then maintain it over years. Also it
brings limitations, that sometimes can be workarounded in the virtio
spec, but this always comes at a cost of decreased readability and
increased complexity. Overall it looks clearly as a downgrade compared
to virtio-video for our use-case. And I believe it would be the same for
every developer, that has to actually implement the spec, not just do
the pass through. So if we think of V4L2 UAPI pass through as a
compatibility device (which I believe it is), then it is fine to have
both and keep improving the virtio-video, including taking the best
ideas from the V4L2 and overall using it as a reference to make writing
the driver simpler.

>>>> 2. There is no flexibility to choose whatever way of memory management
>>>> host and guest would like to use. Now the guest user-space application
>>>> selects this.
>>>
>>> Errr no. The guest user-space chooses a type of memory from what the
>>> guest kernel exposes, which depends on what the host itself decides to
>>> expose.
>>
>> I don't agree. If an already written user-space app supports only MMAP,
>> then there is no way to force it use USERPTR, right? Please correct me
>> if I'm wrong.
>
> The memory types exposed by the guest kernel do not need to match
> those exposed by the hypervisor or that the guest kernel chooses to
> use.
>
> For instance, imagine that the hypervisor does not support allocating
> buffer memory - i.e. it does not support the MMAP memory type. The
> guest will then have to use its own memory for buffer allocation, and
> send them to the host with the USERPTR memory type.
>
> Now if a guest user-space application only supports MMAP, that's not a
> problem at all. Most V4L2 drivers allocate MMAP buffers from regular
> memory. So when the application requests MMAP buffers, the guest
> kernel can honor this request by allocating some memory itself, and
> changes it to USERPTR when passing the request to the hypervisor so it
> knows that guest memory is in use.
>
> I am responsible for this misconception since I insisted on using the
> same memory types (MMAP, USERPTR, DMABUF) as V4L2 for guest/host
> communication, which is misleading. It would probably be less
> confusing to define new types (HOST, GUEST and VIRTIO_OBJ) just for
> virtio-v4l2 and forbid the use of the kernel/user space memory types.
>
> With these new names, I think it is clear that we have the exact
> feature set of virtio-video (guest memory and virtio objects) covered,
> plus another one where we allow the host to perform the allocation
> itself (which may be useful if the video device has its own dedicated
> memory). Again, this is only for host/guest communication. Guest
> kernel/userspace is a different thing and can be implemented in
> different ways depending on what the host supports.

Thank you very much! This is basically the same thing, that I called
"rewriting the flow of V4L2 UAPI calls on the fly" earlier. You can find
the quote in this email below. As I wrote in the quote, this already
seems hackish to me.

Ensuring consistency everywhere, always remembering in which context a
particular VIDIOC_SOMETHING command is used. Is this command used in
host to guest interaction or in kernel to user-space interaction? You're
going to have problems grepping the code. Well, maybe it can be clearly
separated from each other and from the pass through case. I'm sure it
will still create a lot of confusion.

You went further and suggested to redefine the memory types for
host-guest interactions. I agree completely! This is absolutely the
right thing to do. Mapping original V4L2 memory types would be awkward.
At the same time you now have to remember, that there are two
definitions of enum v4l2_memory, one in the spec, and one in
buffer.html. And you have to remember, that the one from the spec has
priority for host-guest interactions, and the one from buffer.html has
priority for kernel to user-space interactions. That's why I call it a
workaround.

This reminds me another benchmark for code quality: the amount of WTFs
per minute. :)

>>>> The latter makes the solution much less flexible IMO. For example, thi=
s
>>>> won't work well with our hypervisor. There might other special needs i=
n
>>>> other use-cases. Like sharing these object UUIDs. Probably this can
>>>> handled by mapping, for example, V4L2_MEMORY_USERPTR to guest-pages
>>>> sharing, V4L2_MEMORY_DMABUF to the UUIDs (which is not quite correct
>>>> IMHO).
>>>
>>> Please elaborate on why this is not correct.
>>
>> Because IMHO UUIDs pointing to memory allocated by virtio-gpu are quite
>> different dmabufs created in the guest with udmabuf, for example. This
>> can be confusing.
>
> True, and that's another reason to define our own memory types to
> remove that confusion.

Yes, and I'm very happy we agree on this.

>>>> So this already means querying the device for supported sharing
>>>> methods, rewriting the flow of V4L2 UAPI calls on the fly, ensuring
>>>> consistency, etc. This already looks hackish to me. Do you have a bett=
er
>>>> plan?
>>>
>>> How do you support different kinds of memory without querying? Or do
>>> you suggest we stick to a single one?
>>>
>>> I am also not quite sure what you mean by "rewriting the flow of V4L2
>>> UAPI calls on the fly". There is no "rewriting" - V4L2 structures are
>>> just used to communicate with the host instead of virtio-video
>>> structures.
>>
>> I'd like to know your ideas or better a concrete plan for enabling
>> user-space apps, that only support MMAP, to work on top of a device,
>> that supports only guest pages sharing.
>
> Hopefully my explanation above clears that.

Yes, thank you.

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

