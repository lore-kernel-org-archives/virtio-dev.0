Return-Path: <virtio-dev-return-12242-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4138EC77B73
	for <virtio-dev@archiver.kernel.org>; Sun, 16 Apr 2023 13:42:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 585952CAEA
	for <virtio-dev@archiver.kernel.org>; Sun, 16 Apr 2023 13:42:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BAAE986406
	for <virtio-dev@archiver.kernel.org>; Sun, 16 Apr 2023 13:42:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B870985FF0; Sun, 16 Apr 2023 13:42:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1165D985FF8;
	Sun, 16 Apr 2023 13:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce8MIHEY7lAxDfP1fTYdEmkT1fbBBEGBqO9zUMcji86OZx4f93/abrzyDupI0H+t3l2aeA2+nRObEXlPVnpJSBMlPAORJlAr1E6KkQrrwO4AaeyV8pazWGLVnygoHIfaGTidU10oT4bJann1zRcXvEJoh4LYPUFN6SK4hIjJh2PDBkcKcBN0AjBfo3VAJ1jtQHcQps8RnXK0cORzBL5PnOciLLGveoe7Y8fGwd1v9aZfiKVB1won1+MIYYYJp8CohHpSAWtZQhMcsPs6gsY6SoZ/EeMGgyV6LZVIyXO8cxONoWnPL4/2IceYjErcpyH3AzsyP5dM4m8fYwU9P3Cdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCsZMPEY9nN+SaVCx6jaEc/Fqgoh3MLkHZs+uDQ9ewg=;
 b=O2HZCkWhNl/kV4FBSx9Ztwqxw2wJi72MWEpxA9bOsmIq71/dpVE1Wc/j4P7HjU5nvEEs8nobtQcnwjpRVFx3jSBcwsnzSNkQfOxKa51QMK1U+5oCFoKmzpE1mNQvDVgRI8Mzk70f0LrSQS+35jWIuuAO0IKKPKvygt5aMhl/ZkAveuzfMKpqq9886quoftj5/Q2XXBfm+SBYh44g60gyk6dHAUFgJICbmjwJ/a99eTYl97oo0K0QfSJHTye64x9FIz9S1mKRwGg5vCjf6l3oAyC5wRpgsqdnB/He4QlgFpdMK9F0/VE4tszxxLOzilOKDgo2d4LBhOuLo70UjM5/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgAA85gCAAABI8IAAXS4AgAAARpCAAEh7AIADk47Q
Date: Sun, 16 Apr 2023 13:41:55 +0000
Message-ID:
 <PH0PR12MB5481F9D94282F794E0A08BF0DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230414025523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230414025523-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5275:EE_
x-ms-office365-filtering-correlation-id: 42503ab9-a71c-40cc-1cc6-08db3e8057f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0Pc+NO0su2f1bMAHPHDXNeRud2Unvr6qiTZEGCN6tgeq1LCiLjHac7tPdYh8PwQ+7Gjtts4WiMWSao31WtlzhB0nF38EaP7mJXVRF/Ak4L6x7ZBKh02SjN9iXCxgiRzY51MIxFgacuztcWeU0P99nXKzNh0o7W8lZvjKkjmvCP8FYPLnADm8NRdHRj7w11Dxo3b4EbWOnb7gnfxTCGlWqTmBM6Td360dbMgCEWY/On10bgjqkBjvN1XYTysjSBxSb136b4ADPdu8WetQ1IfQ9HThqUizCxRwFJLCcj4uhm7vKLghIeqxvaz9alSNv1WaFIX9QcnYWZfqsojmIXeiVxUsdWfmjJ1waD3cmXG6sL+H88lpXK3A9Vpnr28brCN619AGFFniD5IUl7afYZIERj0l8C3dPoXO6sMQHqww0uhLpOu/cbRxOt3EMCnoZLzxLn0PjXb+VwT0cvFFR/7yAR6XaAw/CbzxVcok3lr6MIWnoIjhCRkX/rrPtHULp2X2tn0IdjoRClIZudwDFOEpELRYXJQEysu8CIZ2FmIxFxawJayJQLLPYBLGGjdAJ+ZEFFlW9IL8GSYBZYIpKUGYZejG97kjfQwUXHaFuOUG+VpBKhOBH6nzU4jLlwn/pJb6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(54906003)(186003)(26005)(6506007)(38070700005)(83380400001)(38100700002)(4326008)(6916009)(66946007)(66556008)(66476007)(64756008)(66446008)(76116006)(9686003)(478600001)(71200400001)(4744005)(2906002)(33656002)(41300700001)(316002)(122000001)(8676002)(86362001)(7696005)(8936002)(55016003)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHRwMFlTckU5OWxtWDlVZnR5THRmNk5IcWNKbzh1YXJVdXVWWHNMendRTHpK?=
 =?utf-8?B?ZHJMdVRCazNLb3UrN0lsWFlTWGlNaDRuUzVNOEoraG5zcEg5T3lVcWZRMDV3?=
 =?utf-8?B?ODdiaFRpTnFSMUZqQWpKQnRPOEN4MThPampPNFdjNUI4Tnk5NWM5L2xZMzBx?=
 =?utf-8?B?bmU5aG90MnRQRWZ2K3VSaG9EbXQ5cVhxdThzU3BGOEJING9tRzVlL0MwZk9E?=
 =?utf-8?B?QjhOQTcxVWl4QlZzS3JuQlU5L3R6OTNuRGVhR2JkMVp0d1VUeWh1U29JbUNX?=
 =?utf-8?B?dlI4SlVNMFBYMVFWTnFKV3R0RWxFcWlUbEROSlFpRFh2M252VGJRVEh5dGFn?=
 =?utf-8?B?WEZiRFpwZEp0UTZlc0dIbG5ySk9Denhxd3kzY2J5YXZma0F5VUU4aDVmeE4z?=
 =?utf-8?B?ZTV1N3RGaG9pOFZ3TzdWV2pzcVovTzhhVGM0Nm9zbXlxQllUUDZQRmNDK0p0?=
 =?utf-8?B?RitZcW9zSVJJK1J0RnRBL1ZWVjNnTUs4eS92UjRaOERxUG1FOGtZVzZSOWR0?=
 =?utf-8?B?a3BUOGNPNWhLaW5lUjQ1cmtGNmxUYjM1dXNqUTZ6b2pMV3l5cWRaVlptR3pp?=
 =?utf-8?B?ZHFmNjRsWmhoZUpzWXdTa1czUVpTWmlkRnU4S1JLdVFqcDRQUldacitlSkVW?=
 =?utf-8?B?THgxKzhWMWhEaHhjZjE1d2pCQjRuTXVGZ0l2ZmMrWXBMNWJoMlVtTVlMQnVS?=
 =?utf-8?B?akd3bDlvL2hyc0RzVXcvVlF3QTNxZlRYbXV1ZkF3WjQvWG1GTXg1bmZ2WDNR?=
 =?utf-8?B?UDlFK0lvUlJMVTExS21UaDJQRjNEMXdXSVlVQ3pOZms1c1JIcHQyTG5lWDdr?=
 =?utf-8?B?WFMxalFhVVZlWWZxN29wM0R2UnVMTEJjUkszbkZUOTV2ZTZWbUdZZmlxK1Zx?=
 =?utf-8?B?Q3RORm5QaStUcmF4eFlkQUNoWHRISmlZcENOOFlZZUlHQzZNblRWT2xqZFAv?=
 =?utf-8?B?UFZuZmNYZVlBVktGNTZZekM2RE85ZFFyM1hkcGdlU1VTb2NadDlXZWdwN2hs?=
 =?utf-8?B?c3VLOVozRTcvQy9CdXc1enZFcnl5WVpxNWk1VkNHYkJ2K2hxa01YOE42cmlr?=
 =?utf-8?B?VFpKZGdiSjJYOVFwN0R6K1ZZMkRSRTE5RFBpYk1qalZYdXJKeE9Zbk5aOE0y?=
 =?utf-8?B?ZzBSN2hnY0ZGYVBDOGhuS3RIU3d6clVqcVZub1V5MmtObk80OU5Idm5ReU5G?=
 =?utf-8?B?eWU0ZU5EYVV6ZmZRU0ZzcVhRTHB2QW5pUExBMkxURXBWR2cwQnF5LzBtY3Bn?=
 =?utf-8?B?cVJMbGFHcmFBVS9HckRKSjJOaDlHcE9HM3hjNVNPaFp3dHFIUmZERFZZcS91?=
 =?utf-8?B?SStEMnEvWXpvK3h5MTVvWC9zdWZsTm9HcWFxdUEwR2Y3NkFIdUtXSjNMV1kw?=
 =?utf-8?B?L2VVdldpam14OElMN2k3T1VpU010ZEhiNEN3d2xZNmxuSEhLaDJsK1dSKy9h?=
 =?utf-8?B?d3Q4U3BtR2FmaCt4WkdnN1FORTdDZ25RV1o5VkVEazZHSlYwTTcxZjBrRVAv?=
 =?utf-8?B?QTVzazlZS0c5emEvU2tKNW91bFc3UytBNGZoYkI0clZYT0ZIdGpUbWZvMFNI?=
 =?utf-8?B?RzVWUjNxME53Zkpza0N1Ujl4RVFQZ2FYQkY1NnNVV0RwODFlTittYzZYN0t2?=
 =?utf-8?B?MzZjam5XeU1CQzJ2MUYrdVRoUmdUMGEvNjBPNmhyYWlYUnQ2ZDdjZmpkd0Vw?=
 =?utf-8?B?Z2dJWFlyLzZMYit6S2xNeGc1d1BmT3BOVHJabUlSVkg2QVVEOGZTZ3RZajhC?=
 =?utf-8?B?TWMzZyt2YUlad2NGRUJYTk9QblRtL1Y1ckg2Yk13RmFzT2h6eW5zRHgxK2kv?=
 =?utf-8?B?THZqMEZQRjlTNnZLLzF4UTJ2cnZvQTZxWG0vdjI1bisyeUFlYy9oNmZtS0xy?=
 =?utf-8?B?VW1hbVVOMHp5dnpZakNWd2V3U1MrajU5VU8vUkpvYmpWMFV2aDQxLzFBS3Z3?=
 =?utf-8?B?WjNEU0NQbmZGYVlTMXBVVWJ5UXY4YWl6dEpRZ3RHOGR5c0Q2dGJYaC9SY3Rv?=
 =?utf-8?B?dTF5VjJVcUwySjRDN3VZRFBFOGdzd25ybzVwNGVhaDJUTkVEY0VReGovWVpM?=
 =?utf-8?B?b09zT0NHT1Rhd05PaE0wVkdBUWdTMFFaWE1md2R5WC9CeHJFVFJkZmJxaFFv?=
 =?utf-8?Q?NU5M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42503ab9-a71c-40cc-1cc6-08db3e8057f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 13:41:55.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJWLkC+MfTx6UgwJgK2nC61VdKWhKfVAPEbdGxVKR+0FUwjpyRjmLL9cJ+5TFGpmMVzG0bcFZoicMlXhW5hd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

PiBGcm9tOiB2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvLWNvbW1l
bnRAbGlzdHMub2FzaXMtDQo+IG9wZW4ub3JnPiBPbiBCZWhhbGYgT2YgTWljaGFlbCBTLiBUc2ly
a2luDQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTQsIDIwMjMgMjo1NyBBTQ0KIA0KPiBEbyB5b3Ug
cmVmZXIgdG8gdGhlIHRyaWNrIEphc29uIHByb3Bvc2VkIHdoZXJlIEJBUjAgaXMgbWVtb3J5IGJ1
dCBvdGhlcndpc2UNCj4gbWF0Y2hlcyBsZWdhY3kgQkFSMCBleGFjdGx5PyBJcyB0aGlzIHlvdXIg
cHJlZmVycmVkIHNvbHV0aW9uIGF0IHRoaXMgcG9pbnQgdGhlbj8NCg0KV2UgbG9vayBhdCBpdCBh
Z2Fpbi4NCkFib3ZlIHNvbHV0aW9uIGNhbiB3b3JrIHJlbGlhYmx5IG9ubHkgZm9yIGEgdmVyeSBz
bWFsbCBudW1iZXIgb2YgUEYgYW5kIHRoYXQgdG9vIHdpdGggdmVyeSBzcGVjaWFsIGhhcmR3YXJl
IGNpcmN1aXRyeSBkdWUgdG8gdGhlIHJlc2V0IGZsb3cuDQoNClRoZXJlZm9yZSwgZm9yIHZpcnR1
YWxpemF0aW9uIGJlbG93IGludGVyZmFjZSBpcyBwcmVmZXJyZWQuDQphLiBGb3IgdHJhbnNpdGlv
bmFsIGRldmljZSBsZWdhY3kgY29uZmlndXJhdGlvbiByZWdpc3RlciB0cmFuc3BvcnQgb3ZlciBB
USwNCk5vdGlmaWNhdGlvbiB0byB1dGlsaXplIHRyYW5zaXRpb25hbCBkZXZpY2Ugbm90aWZpY2F0
aW9uIGFyZWEgb2YgdGhlIEJBUi4NCg0KYi4gTm9uIGxlZ2FjeSBpbnRlcmZhY2Ugb2YgdHJhbnNp
dGlvbmFsIGFuZCBub24tdHJhbnNpdGlvbmFsIFBDSSBkZXZpY2UgdG8gYWNjZXNzIGRpcmVjdCBQ
Q0kgZGV2aWNlIHdpdGhvdXQgbWVkaWF0aW9uLg0K

