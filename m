Return-Path: <virtio-dev-return-11492-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D343BC678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03B433243
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D3EF986859
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:05:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59FC19866E5; Tue,  7 Mar 2023 19:05:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58C869866DE;
	Tue,  7 Mar 2023 19:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srw8qjUBzw7ulzQd+6S5YfGDgM3vKhFq85ipinnMHpuoqpXs6P8B1kcUCa/IH8/lPZ6qPrI8pZEXoo7HC6bSW79+MtiB4LRHVzHv5DRPTLsrMTwBapNbelmUDnAVmRjtr7gyIkr1/agaQFOamCqIMPaALS+DdEt4BM6KWjpowUCmU5EY5l0TCd2kYPEvQNMEEs23imd7LvzLmYGSHrnxMX++9Wox6HlapNbBMbKHMUAJGPPFP7X1QRK8QJtf4afl887zIFfoOaNaCLPHI+YRZy017Gkp6cKaxt7nrVZjmGyt4kabwhiA2fWzy5ONPbrbcpVgr+l0ky1wzVZDa1m6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISxndFuASAJQm6nqTCsXLPzj5mdYCSqIiRHL0ylbks8=;
 b=cilfVhssWvY0ylBseMccTBvmQmrNh6O0zOOW+2absEfpKWDbeIbGIKwsw7xQD5nf4r75S3vuE7vt660A0ALv/evhxmOZsRc/xGsx1/1wIgvdj+AtZ36vy0kAK0EH93ZNVUvh5qaKqK7hu8ziYI6+igKTyYB6m231RDIn/c5aTpOoldo/B+sXi0K0KbrC2X2eoyYI1QOQnMgCinSoEqxWySxQNPPmb9tWh4l3VSWoAHVkpzggmJY9JTdkjh/oRfa1a3GdzOY2as4pRqz49pHBD2hLYkGxwLT7wDEfWXZCz4yD5azJxvsfRAlo8E0HMeJqKMBDqfiDon8Ags7LxrL0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues
Thread-Index:
 AQHZTQegoqm3ZFh/hkOgShx3CSU6867n9EmAgAA5TwCAAOB7AIAAAnmAgABw4oCAAnEigIAA8WoAgACFfwCAADfJAIAARSqAgAAQFwCAAb2vkA==
Date: Tue, 7 Mar 2023 19:04:54 +0000
Message-ID:
 <PH0PR12MB5481F9231F27D06A0C630439DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
In-Reply-To: <20230306162538.GA56760@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7672:EE_
x-ms-office365-filtering-correlation-id: ddc977d2-7440-4de0-0a42-08db1f3ed608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pbv5nLptSIQvGRt8rfpNBJI2oKAZfgTs0YMREgqqSgg500/hWIA9OJptvIKXArbLEDjZAqe2LQgcBEuSwzZzJJbc4/CzkhetnVCTZUev+5bCSdWpiOR2BXLVgUFDyzMVtqnmCN5bF2SgOnOMVASxd/HSa3uiNc4K/Xrq7ZCKUx9IclNcOjanGpN2AVLOmjU8JPvg8TlwaHRdc4+zwhAiioKcfi5k8V7hzYaAmkI/t9/+l1r2tKb0yo1iH/kni/sAzr2OL3joAoOFgrGj8tXkhF9+B8YN1dgv+KevO+EIQXb9Z0pUrao6yI9rnb8Oa2BZ30MH/Ba3XbnRRyI9d5QwEW46FQ3hePq9+1olFjuwYuSUG8mIswIFdBg7qGgl5eJ8H+nRJzwFvIQOtLR+3lF642a03ZUlU09hieCxJGRHTvuLxuIPknxGVGOxTYIYlPdefDfViGUecvuFV6yGgD0UqOxk6Y48lgZ+WH3WqMxKktWrJoLH2wHFdnThgAiFkAXoxoScD5kfc2ay+fM/y3s/+Bq7OHyvbGHMU7VxqQBHAFLa4Ov0YX1oEG660F7saxLTlKD+4rYQXnhatXADsfZ/eICAWOBvDKrrUcpgo9WczVAUgcEcBe9uPaCTR8BbbuAiVbqu1aUSLdEOHUPe1ImCclpxtVEW8FXVvAw6MLBEj9afPjBip6U+A/sxTLv+xrod3LfOTs0zcRLM0FZ2gNCspg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(6636002)(316002)(110136005)(558084003)(83380400001)(54906003)(55016003)(33656002)(86362001)(2906002)(64756008)(9686003)(186003)(76116006)(26005)(5660300002)(478600001)(66556008)(66476007)(8676002)(41300700001)(4326008)(66946007)(6506007)(107886003)(7416002)(66446008)(7696005)(8936002)(71200400001)(122000001)(38100700002)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2R6MmlEODArYys2azJLYisyNDQ1RGFCKytxRnc3N0lHN0NqbTlTaE5zOU1V?=
 =?utf-8?B?YUF4V1p6RFlTajN2Q1BtZXNZMUJURE5qUHpRK3NaV3psdldGSUtTYVpWZ05v?=
 =?utf-8?B?Q2FqS3BON3RpK2RQR0VncTdOQ3hwd3JmU2pJTVdkaS9yRjJzVmFVRXBieE84?=
 =?utf-8?B?K292eUFPU09hMEtTaktnYTZsWHZVU1AzbkMzcEhqNUtzQXV3NzlWTXZMQytS?=
 =?utf-8?B?cFZhOXY2UTNLc2p1SktKWkh6UlowM2NaQSt2ME1WY0N0S2ZKaUVPTXkyYSsr?=
 =?utf-8?B?L3Jyd3dVdkp6UE4rMzd4bVBHalR6ZU9TUitWbmRTZXJqMnRteVFIK004RldG?=
 =?utf-8?B?K0RvM1UrUi9LSys2TmUybTZ0c01Wc1BYQkhhWURXNW1wajl6dnQwV2t4QUJY?=
 =?utf-8?B?ZDUyWWNobldTZ3ZHZk5vYjBRS3QxdFhITFZVWDNFTDIxMFN0cEdNelk2OGNE?=
 =?utf-8?B?d3VuSk1DaUk1UTZQMFZPTnlraXdLQys1Slh0V2JlcFMxS1F0ZlovcU5HenJj?=
 =?utf-8?B?QTE3SVV0OFJia2ZZOFVpWFlSSVNNVHRPRVBIOUpDNkhKWUVaMk1TRysrN05N?=
 =?utf-8?B?S0lRVEJUZDhBNTBkbEwzRnhvZ0dtNFFhQ1pWQWtjWloxSlQwcXBVd2Jqckc2?=
 =?utf-8?B?N1RtNXppNk5WbEswZHJxckpTNnRhVzMrNUFqKzVPdVhqaDg1ZXNGM2Vna284?=
 =?utf-8?B?WFFxOXFZYkd5QzVIMjBLOWczd1cvSHVodmIyUWY0R0R5bUpRUEFDMDlSZmQy?=
 =?utf-8?B?S1AxenZ1dGNuWG0zbVM2eE9ldkwxZkFUckZVQW4rQUw0UkZ0ZnpIMFNSaFVv?=
 =?utf-8?B?Q243SDllQ3FkcTNZcnp0VDRsN21hcm9lZURjemJ2TFk4aHF6bmtWZVNCdTRJ?=
 =?utf-8?B?WFM1Q1JKUGFPODhST0NzVWpRQ29JY2dXOHl5amJyN1hXR2MwUTZxYWx5bjFu?=
 =?utf-8?B?YzQ5aWorL3ZSNFQ0ZWR4bVVZeGRBVE51cG5nNm03ZW9zN1V6NHBhWGlLNEpM?=
 =?utf-8?B?T2VaQ3RhcUEvblQ1djh1SzE1RTF1L1JONW9Db29EcXpaWTMyUi9zcnRZMWRk?=
 =?utf-8?B?THJzc0cvbVlFS1pCQmc1WUU0L2Y1S3JVZEJmNmpaQllENy84bWZ5cUNnbjZO?=
 =?utf-8?B?cmhDam1pQ2NTTVZMbHMxazVPU1BlbTlZUEE2U0xaSnlERFdFd3F4aTZiY2kx?=
 =?utf-8?B?MVpVRkpucUJNU0xRRlhvSm5vU3hudkhmUXpSeU1pcGhoOTQzK1VFM1JMKzZs?=
 =?utf-8?B?T0orTEVuQmFZNndhcEZ0RHNVeWVYdVYyd2VyaEFkbCtPaS91NWJibm5wc0Nl?=
 =?utf-8?B?RmNyYU1DVS9pdjhyVjRZVzk4RWpnTmFLMmEvREZDUzQ0ZDdmOTFaWmtQQzRW?=
 =?utf-8?B?VDRTL1ZTVkFQYU9PMldXTjhBS3dwcFhyVzVTcGMvQ0x3ck1mekZmaW1mWFI0?=
 =?utf-8?B?cnZpN3dFK29kbXhJTXFMUzdFVWN3Q0NKQUJpaHYrdEZtVFRPNVhONkhWWmdh?=
 =?utf-8?B?VjhVNnNrN3hUcWFwNFJnZ1Y2ZnlzTDQwMldOdHVNc3NkdU92VS8zbkRkSlg0?=
 =?utf-8?B?RVoyRmhpNzNFb2gySTBnQVJOdm0xbXl1RkUzNkoySmw5bVpCSzJjZlRUZ2Ju?=
 =?utf-8?B?QUdhc2g2ZjhuREpsaUtKSEVCdytkclh2bGkrR3hucEEwcVZuRmxSd04ra0Zz?=
 =?utf-8?B?QzRtbFBzdldOR3E1SkZac0l0UzNnR2xZc3l4MkdjM0pOT0ZPeGRpM2hwemw0?=
 =?utf-8?B?QmVTS21qUVpQV0R5VWdGOVpZbnVqek1IODR2UkEzNkRNZVFibFI1VnJncEow?=
 =?utf-8?B?M1o0bWVmd0pUR3pvekF3cS85cWRSSFF3ZXJVdXlKOTVxakxTMzQxa2cyYllP?=
 =?utf-8?B?T3IzRnRndUVENDNyRGdKSlJJMHBBeGVVQjFHeHNUczhFU2huZlRZcWdIcEU0?=
 =?utf-8?B?K0Z4VE4raTN1bWw2TXJrcDh2eWJlaTlNYWxjbWM0NExqbjFjOG5XRDdSZEpN?=
 =?utf-8?B?enpBREJMMG5vRitGODA2aW4vU0g0K3FGWlFBalVnSG56MVlaZHJ4U0xLMmNS?=
 =?utf-8?B?cWdWRlhiemwrU05TM2RlMDFzandUY1FzZHVON3I2ekY2OVhLQ2w5VXpibHhL?=
 =?utf-8?Q?KeXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc977d2-7440-4de0-0a42-08db1f3ed608
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 19:04:54.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AFNhCoXv5sCMPHVcoYYSdHshaXy1XnLB8hG8I6LCE/dfqSeMnJOJEbI7VQqzZp7JnNPp2Y+KE4PpfD7mzKuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
Subject: [virtio-dev] RE: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

DQoNCj4gRnJvbTogdmlydGlvQGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW9AbGlzdHMub2Fz
aXMtb3Blbi5vcmc+IE9uIEJlaGFsZiBPZg0KPiBTdGVmYW4gSGFqbm9jemkNCg0KPiBJJ20gbm90
IHNheWluZyB0aGF0IGl0IG11c3QgYmUgcG9zc2libGUgdG8gYWJvcnQgYWRtaW4gY29tbWFuZHMu
IFRoZXJlIGFyZQ0KPiBvdGhlciBvcHRpb25zLCBsaWtlIHJlcXVpcmluZyB0aGUgZGV2aWNlIGl0
c2VsZiB0byBmYWlsIGEgY29tbWFuZCBhZnRlciBhIHRpbWVvdXQuDQpBbiBleGFtcGxlIHdoZXJl
IEVBR0FJTiwgRUJVU1kgY2FuIGJlIHVzZWZ1bC4NCg==

