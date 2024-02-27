Return-Path: <virtio-dev-return-14363-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B86C54798
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 14:13:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92D692AFD3
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 14:13:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C8F8986512
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 14:13:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 60E81983D68; Tue, 27 Feb 2024 14:13:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 515B09863DE
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2024 14:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1709043178.569000
X-TM-MAIL-UUID: 2a9b402c-a700-455d-b17b-827f19c37767
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsUpxGrj1jR3rPEa1Fl48wyizbHGwTwbqXvnP8wf7MSC1Mz1hHHsQidEKp0eEx0PBHQ28POWZldJfSvxxfDqjwm5cU0m/3k+xw2kUVkLeMju86sDT1y1Fu+MQhjYdi+ruGwftrVAxNf21H0FkNzjd72WUJAJkq+lGnm5CaWbdtC7ijFjD5YeI/HiYSaAnJnoxX+lPhycHNd1JgPrJ7St5NQKPnJ/13MZNxasXO6nOME0omSbJjE+jzFHFuqyKsdrPwmgzfT82wLUWMyJxQ3WU+eqvlTFilwGzo6H/L1D9XKW8Y9vKfQ7bbSnp6dS4CpZi0Jk+TWCTdeVveKvaYfeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM0/zP5DynNoPXTA0g7z6XEcypK7pipVNplAuuOim24=;
 b=EXgbHXWxfkPDzqXjJy5eg79yGt1OlKpp6soz4mig5Eo8ES9z6IESyWMA+F2ItdtyrGIB4xzVDgMrlUOBGjpM6d6OyGEbEb/OQ2UYD5n3HfSN8z2mcru/XzLewfIndF4k/As6N0S8OCoErl7KdDPzaXj5/UkM5eiDaBd62LLz9Muz9DbLXHesqbALP1TYO5gb/zCfLz0zVIRMsoWAF/+38uCBqiaM6rXbzV9Vnu/GrNK+KVkRb8xEoWhI/vb3ntZiFQOohra+I2QDOH9WUoDfJtL9oOd+PZzbo7/jzAb/xWqH8/tvVQIG32M77em9y1MPHdNYGr1A6mt40x7p157nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <67c59e4a-7f2f-4d74-a9fc-24346233c8c0@opensynergy.com>
Date: Tue, 27 Feb 2024 15:12:55 +0100
From: Harald Mommer <harald.mommer@opensynergy.com>
To: Mark Brown <broonie@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
 Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <3b8e947c-51fb-461e-bb9e-7bc1bb547471@sirena.org.uk>
Content-Language: en-US
In-Reply-To: <3b8e947c-51fb-461e-bb9e-7bc1bb547471@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|BEZP281MB3285:EE_
X-MS-Office365-Filtering-Correlation-Id: adfeebc6-58e0-4fd4-bc5e-08dc379e3246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TN8KiqxJmSOrGN5gZoau5haMDlptw70oqI5jOTdW+fwLpKwo4qadyD7Y8VcqM2DDxS+Kh2YycDsmdBVDJ9IXS+RolBtP/bNnNIvHbgT+PVDxaQ/Fj7r1YBbnh/iitSbte2mfRnknvVst4RvV5RNdjGbXqeZyiQXdnXkvaWYa5FY8dM1HpZpC/S+8QyTzbS2t2BBowcWfxyKSWOSYi1V6RRHW7o6ONa3M7n70ddRvntZEMxjKs4Ivgkd0gUvwN0vZHjdAFJUq3IjcQ2E0QeCSpi4Z6MWNcE+ju53V9g8jw91uJhRmWkU0ML7jHp1cwh5dLt5QRBEQp6AuiRhdHBbviFMwaJl0862WJMTXfkvUn4o0EdU/4AI4YE6l95pZTl/eateUzNns7nF1sc2mD0rksL4ZXTwVbzh0S+dfw2yxZeEURtl6+3NYJS5EHsE7xeWUX1A6QbEb+THg9QBiylDaQUJS19UjFLT3NpUXAUG4OKXB6DoaLENgIbpYV9saJpdp/70kYS0BtDypcgzoQpTLiGkdz+fIZlTKn7a/A9/NXSLD7H+U+WTgCuYtpGK9S238/5zySZnL2OVFi6R9P4D04g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5XSTF4N1owaUN4T3hvTTR2NWN6OWs1Vnk1N1VQTmF5OUdqQWFuNEkyeXY1?=
 =?utf-8?B?YXFWdnlCWHQ0MzV5TGVCR2ZzV0F2cUpBdTNkbVlYK1Q3akRkMzBrM25xZ25l?=
 =?utf-8?B?MS9xUlExb21XOWwvZ3htUzA5WHhEcmRkRnhSK05TNm1RTUFLeGZnTkkxUGZT?=
 =?utf-8?B?MHd5dEVNSWpJTzN3WDNQL1c1NmdHbWhsYnk5TG50NTd0bTkyQ1VXL09Kc2hB?=
 =?utf-8?B?MStUamlRNHlyTUJZNWY0QWRWbUd4aXYycFRkZlAvd0kxdTRzdFp1dkVacnlp?=
 =?utf-8?B?d0RyNHloTTZRQUczSmNSVDlJM1BXNmM1YjdyVlRmMFVXQkZUejBENlRrTFBW?=
 =?utf-8?B?bVlYdTVWU2JTc0RTTDkvd0ZNRmpRR3dPaHluMldabCtkVFpzdHFvRk94aitr?=
 =?utf-8?B?VnFzUU43SHZ6QjQvV0lKVHRmS3BOK1JsYVJPRjhFeDAvMVNxbGM1VFRUVjln?=
 =?utf-8?B?SVdzS2RxaTR1VWcxYW5hNnR4YmlBUU5haEpkZGN0dm1qRjZLNjdIakErdDVj?=
 =?utf-8?B?cko5WExnRG1CYlh4MTBwQjBZVmxNa3ZvZVEweVJmU2Fock1PU0NuUU90TW5I?=
 =?utf-8?B?TERHeHR1bG9uSW84VkpCQTVPRmVndmJQZ0FieDd0V3QrVUVoME5qaXNod25S?=
 =?utf-8?B?Rlk3aXdJV1B5SHd2anE1Mjc5Y2xzbyswdFpnc3l2bXVtZ1A0UG5zeWpzSURS?=
 =?utf-8?B?YTNEK2Q5ZGJyRFN0Z2dLQUcwNVR4US9iakk3bUxibmZYYk44Q2RxR29maW8x?=
 =?utf-8?B?ZWxxQjFmMlVpTUZxL1NuMVNwYmlpYzFqRENzeHBEU3diejRRcGlqdUZ0Vm9J?=
 =?utf-8?B?YjIzRzFyemVYekJ4cjllTFpNcnNmL1NseVhDemc5R1c5dTJBTkMrRXA5ZjBS?=
 =?utf-8?B?Uk9lQU5CN2hlZzlxMGlNdFZDenlhZnl6SEx5a1FUbXNZN3MxcjQ0Uk9ybFFJ?=
 =?utf-8?B?MW5UYlZybWt6ZmRhRkRVZk9wbmI3aFZMYXQrTEo0SEZ2bUQ3WnlzWmx4cDMz?=
 =?utf-8?B?Q042MmxHa0xuV0lqQis4WVA3QlJvS25aZVlwTFBmeXh0eGZORlR1dnpRNW9S?=
 =?utf-8?B?TkNENXhiSm1jSnRYdlZMUytMTDdYU2I4OWtQVWxDaHIzbnRkSHlDaW9OemZP?=
 =?utf-8?B?MENxUmJUdFg5WFgvQ1NHUkwwQTkya3hoUEFHR2Y1bG5yQVpHUGlzVWxTcHNo?=
 =?utf-8?B?bUNSYjd2TGFVS3M2K2h4ZnVsaDcwTFNLSWVmS0FqS1RURE1QMUc0S2ZQVnFH?=
 =?utf-8?B?ZXZSK2lGcUJPV1RTS1Y4Tndjd3BUNjl4Ny9EeUxxc2ovUTdYUlJWRUxKS2Ns?=
 =?utf-8?B?Qll5WmQ2eDdzQUpEcCsyRGMyUHN5MS9kMkk1cFNYSjkwVmpuL3QrclcvYzgv?=
 =?utf-8?B?K0FkUlE1UGFHWWJ6ZnY4Q2xOdzFDalI0NThQSEh6TzN5MzE4L2NXOGwxN2xV?=
 =?utf-8?B?SmNCTU5HY1pOaDJwd2VoK2dOSGNQbVQvVy81QlJzYkk2RnhIVkQvVnJLVGlz?=
 =?utf-8?B?WVpXL2tYdUkzNEV2SDAzT2t6bDZCMDFzZXFiSG1XQVVqc1NPRlpPU2UvSVlJ?=
 =?utf-8?B?T3IrVjRTdTg3aUdhQjRqMnZLMWNQZzBqWU9TQW0xVUpOV09LemVzWWVtUDlv?=
 =?utf-8?B?R1g4bW9IeVhZRlBPOWh4MUFmci80cDlGa2x3VkxTdUV4eW8zRWFaMW5EQVZR?=
 =?utf-8?B?TzFnejdRL2dFNzQyZ0IrZFBEUGdzalRWRUpURGcrbTZzaTRoNWNMQzR2VUdO?=
 =?utf-8?B?S3J0bi9JZ2hlWkhEdTlIanYwN3dIOStPcU4rRTViTVloOWo0SzNUbkMrUjBK?=
 =?utf-8?B?QnBSVmNRNGJ2N2NHQ2F4SnRPZ2ZRRk9KblU4WVRwYVI4LzJVY0ZmS3lnbnhU?=
 =?utf-8?B?aExuRXZyUEhSdDY4bUVET0JlMFZIWkZPYyt5WDBzM0QybVllSEFnNHhXcGF2?=
 =?utf-8?B?ZEw4VUtGQUU4L3VwS0hVdEFZQWNxZEJ5Wk1EcEd4LzFMNk1JangwTEg0QWIv?=
 =?utf-8?B?NzBqZVNUV3BKdVVHSXF5ZFZUZlVSdzZpaG1HbTU3SEVicG9ZZjM1S1VXdE4z?=
 =?utf-8?B?eGluM1lqdnQ2dWNEWk9CYU01dThrb3l3R3NyZHVLL2Q2UVZtMVZZUmowalpn?=
 =?utf-8?Q?hTgz20dbcd3GT/p5tSucfxCBs?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfeebc6-58e0-4fd4-bc5e-08dc379e3246
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:12:56.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJpNkop/LwcaOuHCm3ulI/K1r4zL8TMMzFUKR5Y7hpLZ9sf7X8xxFCiobcPbfP56an45X18I253k/gHar5SrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3285
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28218.000
X-TMASE-Result: 10--16.618300-4.000000
X-TMASE-MatchedRID: gzVbiXtWD9v5ETspAEX/ngw4DIWv1jSVpolXqDXvwwo+Jg7sQdznaGUi
	+ACiOFh+NpP6fPjCt0wrOgqvcXxVa1poZV15KxdLCI8Pr2jKCJvcHWFKCmADc3gwJo5QMsV9IFY
	uBuhR6ahhFZyDNTP3AjyazTdxuZuUUyVJheAIokvrH5D64+wmquuLKunpGCmt8zKKOVo+pRT+xB
	mGAkKF4NZAHrKQNoq5kq5CF9ZqpC3v/jKQnvpTiiJPlyIC6RpANVBLnmb9Lkn6ZqDtcfRPadabQ
	yTTNN0kRM6aZYcmmw/OQ6Wyb5jK9MRgiG11Ew8d977XxEC4bZMjJDYhnWDzJoTSaNbB0/0xzO3w
	GUoEa8BmQeOhR2JjAhu4QGKffsOe4aJC2xGQDi9h2E52K/iaJtkWepC4TY0TiigP8oUJvRkFMTi
	fQllf0dQGzEzdcrE8coL+SOmOzI+J/JFAsRFjSkI9AEPfED/dqvJX/aNGr9cSCDdzAMeX/Wp2VX
	UuZsR8A/lH/MvdoiZkzeNs4Fp1DTnxJqun3snzbkV4e2xSge7G9niOMzf844mwlNMbQCzk6AFiZ
	QMJkMVXlgroISiHmByFdNnda6Rv
X-TMASE-XGENCLOUD: e060e22d-1feb-4157-be36-26060c136bcc-0-0-200-0
X-TM-Deliver-Signature: AA119CA92A32B14D8F4E5686A0EA7511
X-TM-Addin-Auth: 1LMHesigqTHp0nKR/O3hmI7+a7LquIQbPV3eOsvxBCYPYItgETXhRAjXFTC
	R5gxvcmTxIYKJJLvIiJ4SRoTOILJCLYNrwgQdPj7vyECNkdqHhvC76IV8yMYJDlCrxkFXo9E1Wg
	CVU/8wF7ByVkmlY6Qk/JXko4t2Pcno4KGutx8bJr8cYRJy5zFZv5Llf3k1ZWuLEN7l5n2VNucDi
	zW7yYQFl9QpL8Px3zpzsA0WavyOtaQCNSUZ0Eee69wOY86HdvHzdQ6fSLiN7LOPAyd7YL9pv4qA
	KsomIze+nCKsqBo=.QsS1sRXM/9UNdtV6BEaBeuZck6v8otelueq3QuT3rBISAUMcBnJwR8llYz
	QoMzs1dgegEWYOAYSi90KmqS9+OUTGWQsi4nxAUrtz53y0Z6YSYynUl67+/H4gcIdlGLPaLU6E9
	ZDxPY85IlIrjpAbx1u57TYu6yPDYkP24+B0afSgzgfrgAlLv5V4grfouPXqUC80xHy39WRdVxDT
	TAKL5Q7m+AeSigp4LJz5GgJpYscCY5ZThETMWeTB7b46ss/n8mycPw5vbL/7d+EbPI7WhBvuO7m
	uFLi3dCokPojR3P7+KaQSVymQAq4Xczu4UIbL4ewsQO/7u34bv3M/3EHFuQ==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.

On 13.02.24 18:49, Mark Brown wrote:
> On Tue, Feb 13, 2024 at 02:53:50PM +0100, Harald Mommer wrote:
>
>> +/*
>> + * See also
>> + *https://lore.kernel.org/all/6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com
>> + */
>> +static int virtio_spi_set_delays(struct spi_transfer_head *th,
>> +				 struct spi_device *spi,
>> +				 struct spi_transfer *xfer)
> Please write actual comments that can be read standalone, the reader has
> absolutely no idea why they'd want to follow the link and there's
> nothing being referenced by that "also".
Replace link by Haixu Cui's diagram + explanations.The explanations were 
helpful so I wanted to keep this but the comment may now be too long to 
be accepted. We will see what happens.
>> +static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
>> +				   struct spi_controller *ctrl,
>> +				   struct spi_message *msg,
>> +				   struct spi_transfer *xfer)
>> +	/*
>> +	 * Got comment: "The virtio spec for cs_change is *not* what the Linux
>> +	 * cs_change field does, this will not do the right thing."
>> +	 * TODO: Understand/discuss this, still unclear what may be wrong here
>> +	 */
>> +	th->cs_change = xfer->cs_change;

I got the comment originally from you, Mark Brown. After some digging 
still unclear what should be wrong and in the meantime I think nothing 
is wrong at all. To point you with the nose on the pending issue I added 
this comment here.

I'll remove the comment because I think there is no problem. Please 
protest if I'm wrong.

>> +static int virtio_spi_transfer_one_message(struct spi_controller *ctrl,
>> +					   struct spi_message *msg)
>> +{
>> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
>> +	struct virtio_spi_req *spi_req;
>> +	struct spi_transfer *xfer;
>> +	int ret = 0;
>> +
>> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
>> +	if (!spi_req) {
>> +		ret = -ENOMEM;
>> +		goto no_mem;
>> +	}
> Why not just allocate this once, it's not like it's possible to send
> more than one message simultaneously?
Will be done, struct virtio_spi_req spi_req will become a member of 
struct virtio_spi_priv.
>> +	/*
>> +	 * Simple implementation: Process message by message and wait for each
>> +	 * message to be completed by the device side.
>> +	 */
>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> This is processing transfers within a message rather than messages.
Obviously I did not get the terminology of messages and transfers not 
correct which made the comment wrong. Comment to be corrected (and 
shortened).
>> +		ret = virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
>> +		if (ret)
>> +			goto msg_done;
>> +
>> +		virtqueue_kick(priv->vq);
>> +
>> +		wait_for_completion(&spi_req->completion);
>> +
>> +		/* Read result from message */
>> +		ret = (int)spi_req->result.result;
>> +		if (ret)
>> +			goto msg_done;
> It's not clear why this isn't within _spi_transfer_one() and then we
> don't just use a transfer_one() callback and factor everything out to
> the core?

Lack of experience. I saw one way of doing the job which missing the 
more simple way. Therefore we have reviews. Using now the alternative 
callback which shortens and simplifies the code.

Applied code changes, have to run some more tests.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

